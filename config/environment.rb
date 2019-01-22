ENV["SINATRA_ACTIVESUPPORT_WARNING"] = "false"
#ENV["SESSION_SECRET"] = "179caaecf958c907622a3ab3ae056665f1aecb3f"

require "bundler/setup"
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

require_all "app"
