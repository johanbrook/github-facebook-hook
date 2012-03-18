require "rake"

task :default => [":server"]

desc "Start Thin web server"
task :server do
  puts `ruby app.rb`
end

desc "Deploy app to Heroku"
task :deploy => ["compile:production"] do
  puts `git push heroku master`
end