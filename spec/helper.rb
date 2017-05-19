module Helpers
  def stub_logged_in(is_logged_in)
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(is_logged_in)
  end
end
