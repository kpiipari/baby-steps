class MilestoneController < ApplicationController

    get '/create-milestone' do
        binding.pry
        if logged_in?(session)
            
            erb :'children/create_milestone'
        else
            redirect to "/login"
        end
    end

    post '/create-milestone' do
        #binding.pry
        new_milestone = Milestone.new(params)
        if new_milestone.content == ""
            redirect to "/create-milestone"
        elsif new_milestone.save
            binding.pry
            parent = current_parent(session)
            parent.children << new_child
            redirect to "/parent/#{parent.slug}"
        else
            redirect to "/signup"
        end
    end
end