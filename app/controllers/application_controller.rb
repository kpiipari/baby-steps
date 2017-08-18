class ApplicationController < Sinatra::Base
  include Helpers

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

  get '/signup' do
    if logged_in?(session)
      redirect to "/parent/#{current_parent(session).slug}"
    else
      erb :'parents/create_parent'
    end
  end

  post '/signup' do
    parent = Parent.new(params)
    if parent.username == "" || parent.email == "" || parent.password == ""
      redirect to "/signup"
    elsif parent.save
      session[:id] = parent.id
      redirect to "/parent/#{current_parent(session).slug}"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?(session)
      redirect to "/parent/#{current_parent(session).slug}"
    else
      erb :'parents/login'
    end
  end

  post '/login' do
    @parent = Parent.find_by(:username => params[:username])

    if @parent && @parent.authenticate(params[:password])
      session[:id] = @parent.id
      redirect to "/parent/#{@parent.slug}"
    else
      redirect to "/login"
    end
  end
end