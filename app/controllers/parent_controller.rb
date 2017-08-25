class ParentController < ApplicationController

    get '/parent/:slug' do
        @parent = Parent.find_by_slug(params[:slug])
        if logged_in?(session) && !@parent.nil?
            erb :'parents/show'
        else
            redirect to "/login"
        end
    end
end