class UsersController < ApplicationController
    
    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

    get '/login' do
            erb :'/users/login'        
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            redirect "/signup"
        end
    end

    get '/signup' do
            erb :'/users/create_user'        
    end

    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
           #raise error
            redirect "/signup"
        else
            @user= User.new(name: params[:name], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
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