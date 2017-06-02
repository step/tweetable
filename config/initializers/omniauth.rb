Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['APP_ID'], ENV['APP_SECRET'], {
      authorize_params: {force_login: true},
      hd: 'thoughtworks.com'
  }
end
