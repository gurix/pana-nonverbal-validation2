source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'ahoy_matey' # Ahoy provides a solid foundation to track visits and events in Ruby, JavaScript, and native apps.
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'browser' # Do some browser detection with Ruby. Includes ActionController integration.
gem 'coffee-rails', '~> 4.2'
gem 'exception_notification' # Provides a set of notifiers for sending notifications when errors occur in a Rack/Rails application.
gem 'font-awesome-sass', '~> 4.7.0'
gem 'high_voltage'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mina' # Really fast deployer and server automation tool.
gem 'mini_racer'
gem 'mysql2', '~> 0.3.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.5'
gem 'rails-i18n'
gem 'responders' # A set of Rails responders
gem 'sass-rails', '~> 5.0'
gem 'simple_form' # Forms made easy for Rails
gem 'slim-rails'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'binding_of_caller'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'pry-remote'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers', '~> 3.1'
end
