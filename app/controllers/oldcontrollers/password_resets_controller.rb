class PasswordResetsController < ApplicationController
  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
    @user_session = UserSession.new 
  end

  def create
    @user_session = UserSession.new     
    @user = User.find_by_email(params[:email])
    if @user 
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you"
      render :controller => :user, :action => :new
    else
      flash[:error] = "No user was found with email address #{params[:email]}"
      render :action => :new
    end
  
  end

  def edit
  end

  def update
    @user.password = params[:password]
    # Only if your are using password confirmation
    # @user.password_confirmation = params[:password]

    # Use @user.save_without_session_maintenance instead if you
    # don't want the user to be signed in automatically.
    if @user.save
      flash[:success] = "Tu password ha sido actualizada con exito!"
      redirect_to @user
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Lo sentimos, pero no pudimos encontrar tu cuenta"
      redirect_to root_url
    end
  end
end

