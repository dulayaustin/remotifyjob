class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    @current_user ||= Current.user
  end
  helper_method :current_user

  def current_account
    @current_account ||= current_user.account
  end
  helper_method :current_account
end
