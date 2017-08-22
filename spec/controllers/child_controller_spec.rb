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
end