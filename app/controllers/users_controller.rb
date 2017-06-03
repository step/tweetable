class UsersController < ApplicationController

  def index
    is_active_user = current_user.active
    if is_active_user
      redirect_to passages_path
    else
      render :index
    end
  end

  def record
    @users = User.where.not(id: current_user.id).order('name ASC')
  end

  def update
    user = User.find(params[:id])
    update_params(params)
    user.update_attributes(permit_params)
  end

  private

  def permit_params
    params.require("user").permit(:admin, :active)
  end

  def update_params(params)
    params[:user][:active] = params[:user][:active].eql?('1') ? true : false
    params[:user][:admin] = params[:user][:admin].eql?('1') ? true : false
  end

end
