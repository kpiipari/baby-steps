require 'sinatra/base'

class MilestoneController < ApplicationController

    enable :method_override

    get '/child/:slug/create-milestone' do
        if logged_in?
            @child = Child.find_by_slug(params[:slug])
            erb :'milestones/create_milestone'
        else
            redirect to "/login"
        end
    end

    post '/child/:slug/create-milestone' do
        @new_milestone = Milestone.new(:content => params[:content], :date => params[:date], :age => params[:age])
        @child = current_parent.children.find_by(:name => Child.find_by_slug(params[:slug]).name) 
        if @new_milestone.content == "" && @new_milestone.date == "" || @new_milestone.age == ""
            redirect to "/child/#{@child.slug}/create-milestone"
        elsif @new_milestone.save
            @child.milestones << @new_milestone
            redirect to "/child/#{@child.slug}"
        else
            redirect to "/signup"
        end
    end

    get '/child/:slug/milestone/:id' do
        if logged_in?
            @child = current_parent.children.find_by(:name => Child.find_by_slug(params[:slug]).name)
            @milestone = @child.milestones.find_by(:id => params[:id])
            redirect to "/child/#{@child.slug}"
        else
            redirect to "/login"
        end
    end

    get '/child/:slug/milestone/:id/edit' do
        if logged_in?
            @parent = current_parent
            @child = @parent.children.find_by(:name => Child.find_by_slug(params[:slug]).name)
            @milestone = @child.milestones.find_by(:id => params[:id])
             
            erb :'milestones/edit_milestone'
        else
            redirect to "/login"
        end
    end

    patch '/child/:slug/milestone/:id' do
        @parent = current_parent
        @child = Child.find_by_slug(params[:slug])
        @milestone = @child.milestones.find_by(:id => params["id"])
        
        @child_parent = ChildParent.find_by(:child_id => @child.id)

        if @child_parent.parent_id == @parent.id
            if params["content"] != "" && params["date"] != "" || params["age"] != ""
                @milestone.content = params["content"]
                @milestone.date = params["date"]
                @milestone.age = params["age"]
                @milestone.save
                redirect to "/child/#{@child.slug}"
            else
                redirect to "/child/#{@child.slug}/milestone/:id/edit"
            end
        else
            redirect to "/login"
        end
    end

    delete '/child/:slug/milestone/:id' do
        @parent = current_parent
        @child = Child.find_by_slug(params[:slug])
        @milestone = @child.milestones.find_by(:id => params["id"])
        
        @child_parent = ChildParent.find_by(:child_id => @child.id)
        if @child_parent.parent_id == @parent.id
            @milestone.delete
            redirect to "/parent/#{@parent.slug}"
        else
            redirect to "/login"
        end
    end
end