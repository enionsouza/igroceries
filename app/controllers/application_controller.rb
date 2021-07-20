class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    User.exists?(session[:user_id])
  end
  helper_method :user_signed_in?

  def authorize
    redirect_to '/login' unless user_signed_in?
  end
end
