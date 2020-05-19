class HabitsController < ApplicationController
   #read
    get '/habits' do
        if logged_in?
            erb :"habits/habits_index"            
        else
            redirect "/login"
        end
    end

    get '/habits/:id'
        if logged_in?
            @habit = Habit.find_by(id: params[:id])
            redirect '/habits/show_habit'
        else
            redirect "/login"
        end
    end
end