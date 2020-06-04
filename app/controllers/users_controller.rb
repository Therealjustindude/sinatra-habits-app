class UsersController < ApplicationController
    
    get '/users/:id' do
         verify_user_logged_in
         @user = User.find_by(id: params[:id])
         if !@user || @current_user.id != @user.id
            flash[:error] = "You can't view that Users page."
            redirect "users/#{@current_user.id}"
         else
            erb :'/users/show'
         end
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
            user= User.new(name: params[:name].downcase, email: params[:email], password: params[:password])
                if user.save
                    session[:user_id] = user.id
                    redirect "/users/#{user.id}" 
                else
                    flash[:message] = "An account is already in use with this email."
                    redirect "/signup"
                end
         end
    end

    get '/logout' do
        redirect "/" if !logged_in?
            session.destroy
            redirect "/" 
    end
end