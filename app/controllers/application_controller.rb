class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :logged_in?, :current_user

  def current_user
    User.find_by(auth_id: session[:auth_id])
  end

  def logged_in?
    current_user.present?
  end

  def set_current_tab(tab)
    session[:current_tab] = tab
  end


  private

  def current_tab
    session[:current_tab] || (current_user.admin ? :drafts : :commenced).to_s
  end

  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end
end
