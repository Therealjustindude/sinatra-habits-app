class HabitsController < ApplicationController
   #read
    get '/habits' do
        erb :"habits/habits_index"
    end

    get '/habits/:id'
        redirect '/habits/show_habit'
    end
end