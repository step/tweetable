class SessionsController < ApplicationController
  skip_before_action :require_login, :active_user?, only: [:new, :create, :destroy]

  def new
    redirect_to passages_path if logged_in?
  end

  def create
    email = user_params[:email]
    user = User.find_by(email: email) || User.create(user_params)
    user = user.update_if_changed(user_params)
    assign_session_details(user)
    redirect_to passages_path
  end

  def destroy
    session.delete(:user_id)
    session.delete(:user_name)
    session.delete(:image_url)
    redirect_to login_path
  end

  private

  def assign_session_details(user)
    session[:user_id]=user.id
    session[:user_name]=user.name
    session[:user_image_url]=user.image_url
  end

  def user_params
    omniauth=request.env["omniauth.auth"]
    {
        auth_id: omniauth['uid'],
        name: omniauth['info']['name'],
        email: omniauth['info']['email'],
        image_url: omniauth['info']['image']
    }
  end
end
