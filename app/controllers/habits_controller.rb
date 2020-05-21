class HabitsController < ApplicationController
   #read
    get '/habits' do
        if logged_in?
            @habits = current_user.habits
            erb :"habits/habits_index"            
        else
            redirect "/login"
        end
    end

    get '/habits/new' do
        if logged_in?
             erb :'/habits/create_habit'
        else
            redirect "/login"
        end
    end

    post '/habits' do 
        if logged_in?
            @habit = Habit.new(habit: params[:habit],user_id: @current_user.id)
            @habit.save
            redirect "/habits"
        else
            redirect "/login"
        end
    end

    get '/habits/:id' do
        @habit = Habit.find_by(id: params[:id])
        if logged_in?
           if @habit.user == @current_user
                erb :'/habits/show_habit'
           else
                redirect "user/#{@current_user.id}"
           end
        else
            redirect "/login"
        end
    end

    get '/habits/:id/edit' do
        @habit = Habit.find_by(id: params[:id])
        if logged_in?
            if @habit.user == @current_user
                erb :'habits/edit_habit'
            else
                 redirect "user/#{@current_user.id}"
            end
         else
             redirect "/"
         end
    end

    patch '/habits/:id' do
        @habit = Habit.find_by(id: params[:id])
        if logged_in?
            if @habit.user == @current_user
                @habit.update(habit: params[:habit])
                redirect "/habits"
            else
                redirect "user/#{@current_user.id}"
            end
        else
            redirect "/"
        end
    end
    
end