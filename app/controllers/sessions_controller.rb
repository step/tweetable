class SessionsController < ApplicationController
  helper ApplicationHelper
  skip_before_action :require_login, only: [:new, :create]

  def new
    user = User.find_by(auth_id:session[:user_id])
    redirect_to user_path(user[:id]) and return if helpers.signed_in?
  end

  def create
    user = User.find_or_create_by(user_params)
    session[:user_id]=user.auth_id
    session[:user_name]=user.name
    redirect_to user_path user.id
  end

  def destroy
    session.delete(:user_id)
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
