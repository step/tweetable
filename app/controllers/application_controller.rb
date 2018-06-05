# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :active_user?
  skip_before_action :active_user?, only: [:clearance]

  helper_method :logged_in?, :current_user

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def clearance
    return redirect_to passages_path if current_user.active
    render 'shared/clearance', layout: false
  end

  def verify_privileges(action, subject_class)
    authorize! action.to_sym, subject_class
  end

  rescue_from CanCan::AccessDenied do |exception|
    raise ActionController::RoutingError, "#{exception.message}"
  end

  private

  def active_user?
    redirect_to clearance_url unless current_user.active
  end

  def require_login
    redirect_to login_url unless logged_in?
  end
end
