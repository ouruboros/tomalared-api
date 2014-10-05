class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update] #:show

  def new
    @user = User.new
  end

  def create
#   @user_session = UserSession.new    
    @user = User.new({:name => params[:name], :profile => params[:profile], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation]})

    if params[:accept]      
      # Saving without session maintenance to skip
      # auto-login which can't happen here because
      # the User has not yet been activated
      if @user.save_without_session_maintenance 
        # @usernew.send_activation_instructions! 
        render :json => {:message => "Cuenta creada!!"}, :status => :ok
      else
        render :json => {:message => "Hubo un problema creando tu usuario."} , :status => :ok
      end
    else
      render :json => {:message => "Debe aceptar las condiciones."} , :status => :ok
    end
  end


  # up and delete a user
  def delete_user
    if params[:email] == current_user[:email]  
      user = User.find(current_user[:id])      
      user.destroy
      render :json => {:success => true, :message => "usuario borrado."}, :status => :ok 
    else
      render :json => {:message => "Tienes que introducir tu email para verificar que quieres borrar la cuenta."}
    end
  end

  def crop
    @po = Post.new
    @user = User.find(current_user[:id])
    respond_to do |format|
      format.json
    end
  end

  def edit
    @po = Post.new
    @user = User.find(current_user[:id])
    if params[:remote]
      respond_to do |format|
        format.json
      end
    end
  end

  def updateImage
    @po = Post.new    
    @user = current_user
    @user.photo = params[:user][:photo]
    @user.save
    flash[:notice] = "Tu cuenta ha sido actualizada!"
    respond_to do |format|
      format.js
    end
  end

  def update
    @po = Post.new    
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      render :json => {:success => true, :message => "cuenta actualizada" }, :status => :ok 
      not_conf = NotificationsConfig.new
      not_conf.user_id = current_user[:id]
      if params[:user][:photo].blank?
        if @user.cropping?
          @user.photo.reprocess!
        end
      end
      render :json => @user.to_json
    end
  end

  # user list
  def users
    @users = User.find(:all, :order => 'id ASC')
  end
  
  def list
    if params[:id]
      @users = User.find(:all, 
                         :conditions => {:id => params[:id]}, 
                         :order => 'id ASC')
    else
      @users = User.find(:all, :order => 'id ASC')
    end
    if params[:json]
      list = @users.map {| u | Hash[ name: u.name ]}
      render json: list
    end
  end

  def activate
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)

    raise Exception if @user.active?

    if @user.activate!
      UserSession.create(@user, false)
      @user.send_activation_confirmation!
      redirect_to '/'
    else
      render ':action => :new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :profile, :name, :email,:url, :bio, :password, :password_confirmation, :notifications, :photo)
  end
end

