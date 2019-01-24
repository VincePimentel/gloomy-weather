ENV["SINATRA_ACTIVESUPPORT_WARNING"] = "false"
ENV["SESSION_SECRET"] = "caa61a414fbf122a35940ee0c424ad6968f1809138598df039cd7d027770fecf2f080d2cfbda0429d5d107f68f905
3e016c5aaa5f0cb24b6d6375fb84632ae6c"

require "bundler/setup"
Bundler.require

configure :development do
ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end

configure :production do
  db = URI.parse(ENV["DATABASE_URL"] || "postgres:///localhost/mydb")

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == "postgres" ? "postgresql" : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => "utf8"
  )
 end

require_all "app"
