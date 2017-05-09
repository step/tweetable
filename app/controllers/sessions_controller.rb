class SessionsController < ApplicationController
  helper ApplicationHelper
  # skip_before_action :require_login, only: [:new, :create, :foo]

  def new
  end
end
