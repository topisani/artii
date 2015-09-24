class SessionsController < ApplicationController
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login

  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:success] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      redirect_to(:action => 'home')
    else
      flash[:danger] = "Invalid Username or password"
      redirect_to "login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to :action => 'login'
  end
  def home

  end

  def profile

  end

  def settings

  end
end
