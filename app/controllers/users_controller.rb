class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id).order('name ASC')
  end

  def conformation
    is_active_user = current_user.active
    if is_active_user
      redirect_to passages_path
    else
      render :conformation
    end
  end

  def refine_emails(emails_as_string)
    emails_as_string.split(',').collect(&:strip)
  end

  def create_users
    emails = refine_emails(params[:emails])

    failed = []
    saved = []
    emails.each do |email|
      @user = User.new({email: email, active: true})
      @user.save ? saved.push(@user) : failed.push(@user)
    end
    generate_creation_notice(saved,failed)
    redirect_to(users_path)
  end

  def update
    user = User.find(params[:id])
    update_params(params)
    user.update_attributes(permit_params)
  end

  def leader_board
    users = User.where.not(auth_id: nil, admin: true)
    @leader_list = leader_list(users).sort_by { |user| user[:points].to_i }.reverse
  end

  private

  def generate_creation_notice(saved, failed)
    flash[:danger] = "Users #{failed.map { |user| user.email }.join(', ')} failed to create..." unless failed.empty?
    flash[:success]= "Users #{saved.map { |user| user.email }.join(', ')} created successfully..." unless saved.empty?
  end


  def permit_params
    params.require("user").permit(:admin, :active)
  end

  def update_params(params)
    # TODO refactor this code add some test
    update_key = params[:user].keys[0]
    if update_key.eql?('admin')
      params[:user][:admin] = params[:user][:admin].eql?('1') ? true : false
    elsif update_key.eql?('active')
      params[:user][:active] = params[:user][:active].eql?('1') ? true : false
    end
  end

  def leader_list(users)
    users.map { |user| {
        image: user.image_url,
        email: user.email,
        name: user.name,
        points: user.tags.map { |tag| tag.weight }.reduce(:+)}
    }
  end
end
