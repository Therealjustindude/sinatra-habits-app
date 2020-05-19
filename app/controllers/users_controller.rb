class UsersController < ApplicationController
    
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect "/show" #displays a users page
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/show"
        else
            redirect "/signup"
        end
    end

    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'        
        else
            redirect '/show'
        end
    end

    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            @user= User.new(name: params[:name], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect '/show'
        end
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