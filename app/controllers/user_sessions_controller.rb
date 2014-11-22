class UserSessionsController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:destroy, :show]
  
  require 'authlogic/test_case' # include at the top of test_helper.rb 
  include Authlogic::TestCase 
  
  def new
    user_session = UserSession.new
  end
 
  def create
    activate_authlogic       
    user_session = UserSession.new({:name => params[:name], :password => params[:password]})
    # @user = User.where(:name => user_session.name)
    if user_session.save
      json = {
        id: user_session.attempted_record.id,
        name: user_session.name,
        profile: user_session.attempted_record.profile,
        email: user_session.attempted_record.email,
        token: user_session.attempted_record.persistence_token
      }

      render :json => json, :status => :ok
    else
      render :json => {'errors' => user_session.errors}, :status => :ok
    end
  end
 
  def show
    render :json => {'user_session' => current_user_session.to_compact_user_session}
  end
 
  def destroy
    current_user_session.destroy
    render :json => {:success => true, :message => 'logout succesful!'}, :status => :ok 
  end
end
