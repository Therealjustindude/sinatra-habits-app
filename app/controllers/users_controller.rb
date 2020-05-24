class UsersController < ApplicationController
    
    get '/users/:id' do
         #raise error- your not logged in - log in to view this page
         verify_user_logged_in
         verify_current_user
            @user = User.find_by(id: params[:id])
            erb :'/users/show'
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
            flash[:error] = "Your email or password does not match"
            redirect "/login"
        end
    end

    get '/signup' do
            erb :'/users/create_user'        
    end

    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            flash[:message] = "Please do not leave anything blank"
            redirect "/signup"
         else
            @user= User.new(name: params[:name], email: params[:email], password: params[:password])
                if @user.save
                    session[:user_id] = @user.id
                    redirect "/users/#{@user.id}" 
                end
         end
    end

    get '/logout' do
        redirect "/" if !logged_in?
            session.destroy
            redirect "/" 
    end
end