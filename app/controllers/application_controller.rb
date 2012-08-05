class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_active_admin_user!
    authenticate_user!

    redirect_to root_path, alert: 'Unauthorized Access!' unless current_user.is_admin?
  end
end
