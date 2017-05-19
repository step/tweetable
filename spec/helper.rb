module Helpers


  def stub_logged_in(is_logged_in)
    mocked_app_controller.to receive(:logged_in?).and_return(is_logged_in)
  end

  def stub_current_user(user)
    mocked_app_controller.to receive(:current_user).and_return(user)
  end

  def mocked_app_controller
    allow_any_instance_of(ApplicationController)
  end
end
