class ParentController < ApplicationController

    get '/parent/:slug' do 
        if logged_in?(session)
            @parent = current_parent(session)
            erb :'parents/show'
        else
            redirect to "/login"
        end
    end
end