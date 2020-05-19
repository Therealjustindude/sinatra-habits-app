class UsersController < ApplicationController
    
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect "/show" #displays a users page
        end
    end

    get '/signup' do
        
    end

    post '/signup' do
        
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect "/login" 
        else
            redirect "/"
        end
    end
end