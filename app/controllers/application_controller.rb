class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user, :require_signed_in

  def sign_in_user(user)
    token = user.reset_session_token
    session[:token] = token
  end

  def current_user
    User.find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_user
  end

  def sign_out
    session[:token] = token

    redirect_to new_session_url
  end

  def require_signed_in
    flash[:notice] = "You gotta be signed in!"
    redirect_to new_session_url unless signed_in?
  end
end
