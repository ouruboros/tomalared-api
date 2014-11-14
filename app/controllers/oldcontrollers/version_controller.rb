class VersionController < ApplicationController
  before_filter :require_user, :only => [:number]

  def number
    render :json => {:version_number => '0.2'}, :status => :ok
  end

end
