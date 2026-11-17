# frozen_string_literal: true

# 公開から 3 日たっていない版は依存解決で選ばない（乗っ取られた版をすぐに取り込まないため）。
# Renovate の週次の Gemfile.lock 更新など、間接依存の更新にも効く。Bundler 4.1 以降で有効。
# 緊急で取り込むときは `bundle update <gem> --cooldown 0` を使う。
source 'https://rubygems.org', cooldown: 3

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
