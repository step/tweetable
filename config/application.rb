# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tweetable
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.time_zone = 'Chennai'
    config.generators do |g|
      g.template_engine :erb
      g.stylesheets     false
      g.javascripts     false
      g.test_framework  :rspec, fixture: true, views: false
      g.integration_tool :rspec, fixture: true, views: true
      g.fixture_replacement :factory_girl, dir: 'spec/support/factories'
    end
    config.exceptions_app = routes
    config.tag_colors = ['#ff63a1', '#ffa500', '#ffe900', '#97db4e', '#1bc9e8', '#ff5e5b', '#0f7173', '#28afb0', '#6daedb', '#62B6CB']
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
