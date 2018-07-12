class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    @user = user
    session[:session_token] = user.reset_session_token!
    @current_user ||= user
  end

end
