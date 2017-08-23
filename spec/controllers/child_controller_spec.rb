require 'spec_helper'

describe ChildController do

    describe 'Creating a new child' do
        it 'loads a new page for adding a new child' do
            Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!

            expect(last_response.body).to include("Add a child")
            
        end
    end 
    
    describe 'Childs homepage' do
        it 'loads a new page for a child' do
            parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params

            child = Child.create(:name => "Benny", :dob => "15/03/2016")
            
            get '/child/:slug'

            expect(last_response.body).to include("Benny")
            expect(last_response.body).to include("2016-03-15")
        end
        it 'tells when there are no milestones' do
            parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params

            child = Child.create(:name => "Benny", :dob => "15/03/2016")
            
            get '/child/:slug'

            expect(last_response.body).to include("You have not added any milestones yet")

        end
        it 'shows all the milestones associated with a child' do

            parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            
            child = Child.create(:name => "Benny", :dob => "15/03/2016")
            milestone = Milestone.create(:content => "first steps", :date => "10-09-2016", :age => "13 months")
            child.milestones << milestone
            
            get '/child/:slug'

            expect(last_response.body).to include("first steps")
            expect(last_response.body).to include("On 2016-09-10")
            expect(last_response.body).to include("At 13 months")
        end
    end    
end