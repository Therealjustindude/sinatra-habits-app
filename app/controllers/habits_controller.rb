class HabitsController < ApplicationController
   #read
    get '/habits' do
        if logged_in?
            @habits = current_user.habits.all
            erb :"habits/habits_index"            
        else
            redirect "/login"
        end
    end

    get '/habits/:id' do
        if logged_in?
            @habit = Habit.find_by(id: params[:id])
            erb :'/habits/show_habit'
        else
            redirect "/login"
        end
    end
end