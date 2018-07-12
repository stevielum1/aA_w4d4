class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def require_user_to_be_logged_in
    unless current_user
      flash[:errors] = ["Log in is required"]
      redirect_to new_session_url
    end
  end

end
