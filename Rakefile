ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :migrate do
	`rake db:migrate && rake db:seed`
	puts "Done"
end

task :console do
  Pry.start
end
