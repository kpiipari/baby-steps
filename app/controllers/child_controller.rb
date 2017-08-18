class ChildController < ApplicationController

    get '/create-child' do 
        erb :'children/create_child'
    end

end