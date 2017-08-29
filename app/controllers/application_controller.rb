require './config/environment'
require 'sinatra/base'

class ApplicationController < Sinatra::Base
  include Helpers

    configure do

      enable :method_override
      enable :sessions

      set :public_folder, 'public'
      set :views, 'app/views'
      set :session_secret, "babystep_secret"
    
  end

  get '/' do
    erb :index
  end

  # call logged_in -> if logged_in set current_parent & return true -> if !logged_in return false
  get '/signup' do
    if logged_in?
      redirect to "/parent/#{current_parent.slug}"
    else
      erb :'parents/create_parent'
    end
  end

  post '/signup' do
    parent = Parent.new(params)
    if parent.save
      session[:parent_id] = parent.id
      redirect to "/parent/#{current_parent.slug}"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/parent/#{current_parent.slug}"
    else
      erb :'parents/login'
    end
  end

  post '/login' do
    @parent = Parent.find_by(:username => params[:username])
    if @parent && @parent.authenticate(params[:password])
      session[:parent_id] = @parent.id
      redirect to "/parent/#{@parent.slug}"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to "/login"
  end
end