require_relative './config/environment'
require 'sinatra/activerecord/rake'

def reload!
	load_all "./config" if Dir.exists?("./config")
	load_all "./app" if Dir.exists?("./app")
	load_all "./lib" if Dir.exists?("./lib")
	load_all "./*.rb" if Dir.entries(".").include?(/\.rb/)
end

task :console do
  Pry.start
end
