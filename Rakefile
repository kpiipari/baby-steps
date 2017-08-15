ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

def reload!
  load_all ‘./app’
end


desc "starts pry"
task :console do
  Pry.start
end

# Type `rake -T` on your command line to see the available rake tasks.