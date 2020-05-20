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
            end
        else
        end
    end

    
end