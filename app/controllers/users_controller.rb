class UsersController < ApplicationController
    
    get '/users/:id' do
         #raise error- your not logged in - log in to view this page
            if logged_in?
                @user = User.find_by(id: params[:id])
                 erb :'/users/show'
            else
                redirect "/login"
            end
    end

    get '/login' do
            erb :'/users/login'        
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            #a user might have entered password wrong
            redirect "/login"
        end
    end

    get '/signup' do
            erb :'/users/create_user'        
    end

    post '/signup' do
        redirect "/signup" if !params[:name] == "" || !params[:email] == "" || !params[:password] == ""
                @user= User.new(name: params[:name], email: params[:email], password: params[:password])
                if @user.save
                    session[:user_id] = @user.id
                    redirect "/users/#{@user.id}"
                else
                    redirect "/signup"
                end
    end

    get '/logout' do
        redirect "/" if !logged_in?
            session.destroy
            redirect "/" 
    end
end