ENV["SINATRA_ENV"] ||= "development"

require_relative "./config/environment"
require "sinatra/activerecord/rake"

desc "Set SESSION_SECRET"
task :secret do
	require "securerandom"
	`bundle config session_secret #{SecureRandom.hex(64)}`
	puts "SESSION_SECRET: #{`bundle config session_secret`[142..-1]}"
end

desc "Migrate and seed database"
task :migrate do
	`rake db:migrate && rake db:seed`
	puts "Migration and seeding done"
end

desc "Set SESSION_SECRET, migrate and seed database"
task :start do
	require "securerandom"
	`bundle config session_secret #{SecureRandom.hex(64)}`
	puts "SESSION_SECRET: #{`bundle config session_secret`[142..-1]}"
	`rake db:migrate && rake db:seed`
	puts "Migration and seeding done"
end

task :console do
  Pry.start
end
