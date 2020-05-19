class UsersController < ApplicationController
    
    get '/users' do
        erb :'/users/login'
    end

    post '/users' do
        
    end
end