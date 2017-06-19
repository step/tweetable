# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :verify_privileges, only: %i[index create_users]

  def index
    @users = User.where.not(id: current_user.id).order('name ASC')
  end

  def refine_emails(emails_as_string)
    emails_as_string.split(',').collect(&:strip)
  end

  def create_users
    emails = refine_emails(params[:emails])

    failed = []
    saved = []
    emails.each do |email|
      @user = User.new(email: email, active: true)
      @user.save ? saved.push(@user) : failed.push(@user)
    end
    generate_creation_notice(saved, failed)
    redirect_to(users_path)
  end

  def update
    user = User.find(params[:id])
    # update_params(params) Feels like we do not need this
    user.update_attributes(permit_params)
  end

  private

  def generate_creation_notice(saved, failed)
    flash[:danger] = "Users #{failed.map(&:email).join(', ')} failed to create..." unless failed.empty?
    flash[:success] = "Users #{saved.map(&:email).join(', ')} created successfully..." unless saved.empty?
  end

  def permit_params
    params.require('user').permit(:admin, :active)
  end

  # def update_params(params)
  #   # TODO refactor this code add some test
  #   update_key = params[:user].keys[0]
  #   if update_key.eql?('admin')
  #     params[:user][:admin] = params[:user][:admin].eql?('1') ? true : false
  #   elsif update_key.eql?('active')
  #     params[:user][:active] = params[:user][:active].eql?('1') ? true : false
  #   end
  # end
end
