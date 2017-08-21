class MilestoneController < ApplicationController

    get '/child/:slug/create-milestone' do
        if logged_in?(session)
            #binding.pry
            @child = Child.find_by_slug(params[:slug])
            erb :'children/create_milestone'
        else
            redirect to "/login"
        end
    end

    post '/child/:slug/create-milestone' do
        new_milestone = Milestone.new(:content => params[:content], :date => params[:date], :age => params[:age])
        parent = current_parent(session)
        child = parent.children.find_by(:name => params[:slug].capitalize) 
        if new_milestone.content == "" && (new_milestone.date == "" || new_milestone.age == "")
            redirect to "/child/#{child.slug}/create-milestone"
        elsif new_milestone.save
            child.milestones << new_milestone
            redirect to "/child/#{child.slug}"
        else
            redirect to "/signup"
        end
    end
end