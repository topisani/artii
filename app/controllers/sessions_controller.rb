class SessionsController < ApplicationController
  before_filter :save_login_state, only: [:login, :login_attempt]
  before_filter :redirect_unauthenticated, only: [:profile, :settings, :home]

  def login

  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    respond_to do |format|
      if authorized_user
        session[:user_id] = authorized_user.id
        format.html { redirect_to @user, success: 'Welcome #{authorized_user.username}' }
        format.json { render json: { message: "success", action: "login"}, status: 200}
      else
        format.html { redirect_to :back }
        format.json { render json: { message: "failure", action: "login"}, status: :unprocessable_entity }
      end
    end
  end

  def logout
    unless logged_in?
      flash[:warning] = "Already logged out"
      redirect_to action: "login"
    end
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
