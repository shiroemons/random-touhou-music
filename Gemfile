# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby file: '.ruby-version'

gem 'puma'
gem 'rackup'
gem 'sinatra'

group :development do
  gem 'rubocop', '~> 1.66'
  gem 'rubocop-minitest', '~> 0.36'
  gem 'rubocop-performance', '~> 1.22'
  gem 'rubocop-rake', '~> 0.6'
end
