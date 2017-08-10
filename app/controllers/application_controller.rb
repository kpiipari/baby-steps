class ApplicationController < Sinatra::Base

    configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "babystep_secret"
    
  end

  enable :method_override
  enable :sessions

  get '/' do
    erb :index
  end

end