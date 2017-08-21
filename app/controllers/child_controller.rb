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

    get '/child/:slug' do
        if logged_in?(session)
            #binding.pry
            @parent = current_parent(session)
            @child = @parent.children.find_by(:name => params[:slug].capitalize)
            erb :'children/show'
        else
            redirect to "/login"
        end
    end


end