class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_merchant?, :current_admin?, :customer?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def customer?
    current_user.nil? || current_user.registered_user?
  end

  def current_merchant?
    current_user && current_user.merchant_user?
  end

  def current_admin?
    current_user && current_user.admin_user?
  end
end
