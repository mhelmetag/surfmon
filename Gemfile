# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bootsnap', require: false
gem 'httparty'
gem 'importmap-rails'
gem 'passwordless'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.1'
gem 'rollbar'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'strip_attributes'
gem 'strong_migrations'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'brakeman'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'annotate'
  gem 'web-console'
end

group :test do
  gem 'timecop'
end
