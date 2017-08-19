class ChildController < ApplicationController

    get '/create-child' do 
        if logged_in?(session)
            erb :'children/create_child'
        else
            redirect to "/login"
        end
    end

    post '/create-child' do
        #binding.pry
        new_child = Child.new(params)
        if new_child.name == "" || new_child.dob == ""
            redirect to "/create-child"
        elsif new_child.save
            parent = current_parent(session)
            parent.children << new_child
            redirect to "/parent/#{parent.slug}"
        else
            redirect to "/signup"
        end
    end

end