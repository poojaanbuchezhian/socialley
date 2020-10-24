class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :check_authorization
  #session[:session_key] = '_rails_space_session_id'
  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end
  def param_posted?(symbol)
    request.post? and params[symbol]
  end
  def protect
    unless logged_in?
      session[:protected_page] = request.url
      flash[:notice] = "Please log in first"
      redirect_to  :controller => "user",:action => "login"
      return false
    end
  end
end
