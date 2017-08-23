class ParentController < ApplicationController

    get '/parent/:slug' do 
        if logged_in?(session)
            @parent = Parent.find_by_slug(params[:slug])
            erb :'parents/show'
        else
            redirect to "/login"
        end
    end
end