# frozen_string_literal: true

module Helpers

  def stub_logged_in(is_logged_in)
    mocked_app_controller.to receive(:logged_in?).and_return(is_logged_in)
  end

  def stub_current_user(user)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_user_with_attributes(params)
    mocked_app_controller.to receive(:current_user).and_return(stub_user_with_attributes(params))
  end

  def stub_current_active_user
    user = stub_user_with_attributes(active: true)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_active_admin_user
    user = stub_user_with_attributes(admin: true, active: true)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def stub_current_active_intern_user
    user = stub_user_with_attributes(admin: false, active: true)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def mocked_app_controller
    allow_any_instance_of(ApplicationController)
  end

  private

  def stub_user_with_attributes(params)
    double('user', params)
  end
end
