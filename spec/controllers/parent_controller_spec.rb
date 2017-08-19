require 'spec_helper'

describe ParentController do

    describe 'Parent homepage' do

        it 'shows all the children for a parent' do
            parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            child1 = Child.create(:name => "Frankie", :dob => "1-Jan-2015")
            child2 = Child.create(:name => "Benny", :dob => "31-May-2017")
            parent.children << child1
            parent.children << child2
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!
     
            expect(last_response.body).to include("Frankie")
            expect(last_response.body).to include("Benny")
            expect(last_response.body).to include("2015-01-01")
            expect(last_response.body).to include("2017-05-31")
        end

        it 'shows when parent account does not include any children' do
            Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!
     
            expect(last_response.body).to include("You have not added any children yet")
        end

        it 'includes a link to add a child' do
            Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!
     
            expect page.has_link? ("/create-child")
        end

        it "links each child to child's homepage" do
            Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            child1 = Child.create(:name => "Frankie", :dob => "1-Jan-2015")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!
     
            expect page.has_link? ("/child/#{child1.slug}")
        end


    end


    
end