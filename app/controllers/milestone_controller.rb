require 'sinatra/base'

class MilestoneController < ApplicationController

    enable :method_override

    get '/child/:slug/create-milestone' do
        if logged_in?(session)
            @child = Child.find_by_slug(params[:slug])
            erb :'mielstones/create_milestone'
        else
            redirect to "/login"
        end
    end

    post '/child/:slug/create-milestone' do
        new_milestone = Milestone.new(:content => params[:content], :date => params[:date], :age => params[:age])
        parent = current_parent(session)
        child = parent.children.find_by(:name => params[:slug].capitalize) 
        if new_milestone.content == "" && new_milestone.date == "" || new_milestone.age == ""
            redirect to "/child/#{child.slug}/create-milestone"
        elsif new_milestone.save
            child.milestones << new_milestone
            redirect to "/child/#{child.slug}"
        else
            redirect to "/signup"
        end
    end

    get '/child/:slug/edit-milestone' do
        if logged_in?(session)
            @parent = current_parent(session)
            @child = @parent.children.find_by(:name => current_child(slug))
            erb :'milestones/edit_milestone'
        else
            redirect to "/login"
        end
    end

    patch '/child/:slug' do
        @child = Child.find_by(:name => current_child(slug))
        binding.pry
        @child_parent = ChildParent.find_by(:child_id => @child.id)

        if @child_parent.parent_id == @parent_id
            if params["name"] != "" || params["dob"] != ""
                @child.name = params["name"]
                @child.dob = params["dob"]
                @child.save
                redirect to "/child/#{child.slug}"
            else
                redirect to "/child/#{child.slug}.edit"
            end
        else
            redirect to "/login"
        end
    end

    delete '/child/:slug' do
        binding.pry
        if logged_in?(session)
            @parent = current_parent(session)
            @child = @parent.children.find_by(:name => current_child(slug))
            @child_parent = ChildParent.find_by(:child_id => @child.id)

            if @child_parent.parent_id == @parent_id
                @child.delete
                redirect to "/parent/#{@parent.slug}"
            else
                redirect to "/login"
            end
        end
    end

end