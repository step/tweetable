# frozen_string_literal: true

class UsersController < ApplicationController

  before_action do
    verify_privileges(params[:action], User)
  end

  def index
    @users = User.where.not(id: current_user.id).order('name ASC')
    @roles = Role.all
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
    user.update_attributes(permit_params)
  end

  def filter_users
    users = User.filter_by_passage(params[:passage_id].to_i, params[:status].to_sym)
    render 'users', locals: { users: users }
  end

  private

  def generate_creation_notice(saved, failed)
    flash[:danger] = "Users #{failed.map(&:email).join(', ')} failed to create..." unless failed.empty?
    flash[:success] = "Users #{saved.map(&:email).join(', ')} created successfully..." unless saved.empty?
  end

  def permit_params
    params.require('user').permit(:role_id, :active)
  end
end
