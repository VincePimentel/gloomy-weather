ENV["SINATRA_ACTIVESUPPORT_WARNING"] = "false"
ENV["SESSION_SECRET"] = "caa61a414fbf122a35940ee0c424ad6968f1809138598df039cd7d027770fecf2f080d2cfbda0429d5d107f68f905
3e016c5aaa5f0cb24b6d6375fb84632ae6c"

require "bundler/setup"
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

require_all "app"
