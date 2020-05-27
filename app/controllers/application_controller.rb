require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV["SESSION_SECRET"]
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else 
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def verify_user_logged_in
      if !logged_in?
        flash[:error] = "You must be logged in to continue."
        redirect '/login'
      end
    end
    
    def find_habit
      @habit = Habit.find_by(id: params[:id])
    end
  end

end
