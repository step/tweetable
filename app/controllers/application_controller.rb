class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    User.find_by(auth_id: session[:auth_id])
  end

  private
  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end

  def logged_in?
    current_user.present?
  end


end
