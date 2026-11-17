# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Ruby のバージョンは .ruby-version で管理する。
# ここで ruby を指定すると Gemfile.lock にバージョンが記録され、
# Renovate の Ruby 更新 PR が frozen モードの bundle install で失敗するため指定しない。

gem 'json'
gem 'puma'
gem 'rackup'
gem 'sinatra'

group :development do
  gem 'rubocop', '~> 1.66'
  gem 'rubocop-minitest', '~> 0.36'
  gem 'rubocop-performance', '~> 1.22'
  gem 'rubocop-rake', '~> 0.6'
end
