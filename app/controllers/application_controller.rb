class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :authenticate_user
  before_filter :set_format
  def logged_in?
    @current_user != nil
  end

  protected

  def authenticate_user
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      return true
    end
  end

  def redirect_unauthenticated
    unless session[:user_id]
      redirect_to controller: "sessions", action: "login"
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

  def set_format
    request.format = "json"
  end
end
