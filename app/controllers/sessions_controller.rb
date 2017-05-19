class SessionsController < ApplicationController
  helper ApplicationHelper
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to passages_path and return if logged_in?
  end

  def create
    user = User.find_or_create_by(user_params)
    session[:auth_id]=user.auth_id
    session[:user_name]=user.name
    session[:image_url]=user.image_url
    redirect_to passages_path
  end

  def destroy
    session.delete(:auth_id)
    redirect_to login_path
  end

  private

  def user_params
    omniauth=request.env["omniauth.auth"]
    {
        auth_id: omniauth['uid'],
        name: omniauth['info']['name'],
        image_url: omniauth['info']['image']
    }
  end
end
