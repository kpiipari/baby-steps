require 'sinatra/base'

class ChildController < ApplicationController

    enable :method_override

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
            @parent = current_parent(session)
            @child = @parent.children.find_by(:name => current_child(params[:slug]).name)
            erb :'children/show'
        else
            redirect to "/login"
        end
    end

    get '/child/:slug/edit' do  
        if logged_in?(session)
            @parent = current_parent(session)
            @child = @parent.children.find_by(:name => current_child(params[:slug]).name)
            erb :'children/edit_child'
        else
            redirect to "/login"
        end
    end

    patch '/child/:slug' do
        #binding.pry
        @parent = current_parent(session)
        @child = @parent.children.find_by(:name => current_child(params[:slug]).name)
        @child_parent = ChildParent.find_by(:child_id => @child.id)
        if @child_parent.parent_id == @parent.id
            if params["name"] != "" && params["dob"] != ""
                @child.name = params["name"]
                @child.dob = params["dob"]
                @child.save
                redirect to "/child/#{@child.slug}"
            else
                redirect to "/child/#{@child.slug}/edit"
            end
        else
            redirect to "/login"
        end
    end

    delete '/child/:slug' do
        if logged_in?(session)
            @parent = current_parent(session)
            @child_name = current_child(params[:slug]).name
            @child = @parent.children.find_by(:name => current_child(params[:slug]).name)
            @child_parent = ChildParent.find_by(:child_id => @child.id)

            if @child_parent.parent_id == @parent.id
                @child.delete
                redirect to "/parent/#{@parent.slug}"
            else
                redirect to "/login"
            end
        end
    end

end