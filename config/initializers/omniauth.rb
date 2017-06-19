# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  param = {
    authorize_params: { force_login: true }
  }
  param[:hd] = ENV['ALLOWED_DOMAIN'] unless ENV['ALLOWED_DOMAIN'].nil?
  provider :google_oauth2, ENV['APP_ID'], ENV['APP_SECRET'], param
end
