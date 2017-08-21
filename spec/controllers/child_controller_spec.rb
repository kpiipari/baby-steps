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

        it 'lets a parent to create a new child to their account' do
            parent = Parent.create(:username => "daddyo", :email => "daddycool@example.com", :password => "tiger")
            params = {
            :username => "daddyo",
            :password => "tiger"
            }
            post '/login', params
            follow_redirect!

            find("a[href='#{'/create-child'}']").click

            #click_link 'Add a child'

            fill_in(:name, :with => "Franklin")
            fill_in(:dob, :with => "2 October, 2016")
            click_button 'submit'

            parent = Parent.find_by(:username => "daddyo")
            child = Child.find_by(:name => "Franklin")
            expect(child).to be_instance_of(Child)
            expect(child.parent_ids).to include(parent.id)
            expeecte(parent.children).to include(child.name)
            expect(page.status_code).to eq(200)

        end

    end     


end