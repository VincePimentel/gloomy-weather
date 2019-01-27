# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "sinatra"
gem "activerecord", :require => "active_record"
gem "sinatra-activerecord", :require => "sinatra/activerecord"
gem "rake"
gem "require_all"
gem "thin"
gem "shotgun"
gem "pry"
gem "bcrypt"

group :development do
  gem "sqlite3"
  gem "tux"
end

group :production do
  gem "pg"
end
