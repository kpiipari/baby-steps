class ParentController < ApplicationController

    get '/parent/:slug' do 
        @parent = Parent.find_by_slug(params[:slug])
        erb :'parents/show'
    end

end