# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Views using bootstrap
gem 'bootstrap_form'

# jquery for front-end logics
gem 'jquery-rails'

# handling validity of sessions in back-end
gem 'activerecord-session_store' , '~> 1.1.0'

# gmail authentication using omniauth
gem 'omniauth-google-oauth2'

gem 'coffee-script', '~> 2.4', '>= 2.4.1'

gem 'x-editable-rails'

# Require the Markdown converter gem
gem 'redcarpet' ,'~> 3.4.0'

# automatic evaluator
gem 'after_the_deadline'
gem 'rufus-scheduler', '~> 3.2'
gem 'slack-notifier'
gem 'cancan'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rails-footnotes', '~> 4.0'

  gem 'rubocop', '~> 0.49.1'
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers'
  gem 'pry'
  gem 'pry-nav'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false

  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
end
group :development do
  gem 'timecop'
end
group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
