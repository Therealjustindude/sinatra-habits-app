class HabitsController < ApplicationController
   #read
    get '/habits' do
        redirect "/login" if !logged_in?
            @habits = current_user.habits
            erb :"habits/habits_index"            
    end

    get '/habits/new' do
        redirect "/login" if !logged_in?
             erb :'/habits/create_habit'
    end

    post '/habits' do 
        redirect "/login" if !logged_in?
            @habit = Habit.new(habit: params[:habit],user_id: @current_user.id)
            @habit.save
            redirect "/habits"
    end

    get '/habits/:id' do
        @habit = Habit.find_by(id: params[:id])
        redirect "/login" if !logged_in?
           if @habit.user == @current_user
                erb :'/habits/show_habit'
           else
                redirect "user/#{@current_user.id}"
           end
    end

    get '/habits/:id/edit' do
        @habit = Habit.find_by(id: params[:id])
        redirect "/" if !logged_in?
            if @habit.user == @current_user
                erb :'habits/edit_habit'
            else
                 redirect "user/#{@current_user.id}"
            end
    end

    patch '/habits/:id' do
        @habit = Habit.find_by(id: params[:id])
        redirect "/" if !logged_in?
            if @habit.user == @current_user
                @habit.update(habit: params[:habit])
                redirect "/habits"
            else
                redirect "user/#{@current_user.id}"
            end
    end

    delete '/habits/:id' do
        @habit = Habit.find_by(id: params[:id])
        redirect "/" if !logged_in?
            if @habit.user == @current_user
                @habit.destroy
                redirect "/habits"
            else
                redirect "user/#{@current_user.id}"
            end
    end
    
end