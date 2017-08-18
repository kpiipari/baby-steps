require 'spec_helper'

describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Baby Steps")
    end
  end

  describe "Signup Page" do
    it 'loads the signup page' do
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it 'signup directs user to parent homepage' do
      params = {
        :username => "daddyo",
        :email => "daddycool@example.com",
        :password => "tiger"
      }
      post '/signup', params
      expect(last_response.location).to include("/parent/daddyo")
    end

    it 'does not let a user sign up without a username' do
      params = {
        :username => "",
        :email => "daddycool@example.com",
        :password => "tiger"
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a user sign up without a password' do
      params = {
        :username => "daddyo",
        :email => "daddycool@example.com",
        :password => ""
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a user sign up without an email' do
      params = {
        :username => "daddyo",
        :email => "",
        :password => "tiger"
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a logged in user to view the signup page' do
      parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
      params = {
        :username => "daddyo",
        :email => "daddycool@example.com",
        :password => "tiger"
      }
      post '/signup', params
      session = {}
      session[:parent_id] = parent.id 
      get '/signup'
      expect(last_response.location).to include("/parent/daddyo")
    end
  end

  describe "login" do
    it 'loads the loging page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it "loads the parent's homepage after login" do
      parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
      params = {
        :username => "daddyo",
        :password => "tiger"
      }
      post '/login', params
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome back #{parent.username}!")
    end

    it 'does not let user view login page if already logged in' do
      parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
      params = {
        :username => "daddyo",
        :password => "tiger"
      }
      post '/login', params
      session = {}
      session[:parent_id] = parent.id 
      get '/login'
      expect(last_response.location).to include("/parent/daddyo")
    end
  end

  describe "logout" do
    it "let's a user logout if they are logged in" do
      parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
      params = {
        :username => "daddyo",
        :password => "tiger"
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it "does not let user to logout if they are not logged in" do
      get '/logout'
      expect(last_response.location).to include("/")
    end

    it "does not load /parent/:slug if a parent is not logged in" do
      get '/parent/:slug'
      expect(last_response.location).to include("/login")
    end

    it "loads /parent homepage if a parent is logged in" do
      parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")

      visit '/login'

      fill_in(:username, :with => "daddyo")
      fill_in(:password, :with => "tiger")
      click_button 'submit'
      expect(page.current_path).to eq("/parent/daddyo")
    end
  end
end