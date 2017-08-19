require 'spec_helper'

describe ChildController do

    describe 'Creating a new child' do
        it 'loads a new page for adding a new child' do
            Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            child = Child.create(:name => "Frankie", :dob => "1-Jan-2015")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!

            visit '/create-child'

            expect(last_response.body).to include("Add a child")
        end

    end     


end