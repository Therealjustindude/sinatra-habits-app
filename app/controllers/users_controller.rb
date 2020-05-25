class UsersController < ApplicationController
    
    get '/users/:id' do
         verify_user_logged_in
         if @current_user.id != session[:user_id]
            flash[:error] = "You don't have     permission."
            redirect "users/#{@current_user.id}"
         else
            @user = User.find_by(id: params[:id])
            erb :'/users/show'
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
            @user= User.new(name: params[:name].downcase, email: params[:email], password: params[:password])
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