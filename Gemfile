# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.0.2", ">= 6.0.2.1"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "carrierwave"
gem "bootsnap", ">= 1.4.2", require: false
gem "kaminari"
gem "devise"
gem "omniauth"
gem "omniauth-github"
gem "dotenv-rails"
gem "active_decorator"
gem "aws-sdk-s3", require: false
gem "slim-rails"
gem "html2slim"
gem "bulma-rails"
gem "font-awesome-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "faker"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano3-puma"
  gem "capistrano-nginx"
  gem "ed25519"
  gem "bcrypt_pbkdf"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
