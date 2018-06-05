# frozen_string_literal: true

module Helpers
  def stub_logged_in(is_logged_in)
    mocked_app_controller.to receive(:logged_in?).and_return(is_logged_in)
  end

  def stub_current_user(user)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_user_with_attributes(params, is_admin)
    user = stub_user_with_attributes(params)
    role = is_admin ? Role.admin : Role.intern
    allow(user).to receive(:role).and_return(role)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_active_user
    user = stub_user_with_attributes(active: true)
    allow(user).to receive(:role).and_return(Role.intern)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_active_admin_user
    user = stub_user_with_attributes(active: true)
    allow(user).to receive(:role).and_return(Role.admin)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_active_intern_user
    user = stub_user_with_attributes(active: true)
    allow(user).to receive(:role).and_return(Role.intern)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def mocked_app_controller
    allow_any_instance_of(ApplicationController)
  end

  def stub_env_variable(variable, value)
    stub_const('ENV', ENV.to_hash.merge(variable => value))
  end

  private

  def stub_user_with_attributes(params)
    double('user', params)
  end
end
