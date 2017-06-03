class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :active_user?
  skip_before_action :active_user?, only: [:clearance]

  helper_method :logged_in?

  def current_user
    User.find_by(auth_id: session[:auth_id])
  end

  def logged_in?
    current_user.present?
  end

  def set_current_tab(tab = nil)
    session[:current_tab] = (tab || current_tab )
  end

  def clearance
    return redirect_to passages_path if current_user.active
    render 'shared/clearance', locals: {user: current_user}
  end


  private

  def active_user?
    unless current_user.active
      redirect_to clearance_url
    end
  end

  def current_tab
    session[:current_tab] || (current_user.admin ? :drafts : :commenced).to_s
  end

  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end
end
