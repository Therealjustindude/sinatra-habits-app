class HabitsController < ApplicationController
   #read
    get '/habits' do
        verify_user_logged_in
        verify_current_user
            @habits = current_user.habits
            erb :"habits/habits_index"            
    end

    get '/habits/new' do
        verify_user_logged_in
        verify_current_user
             erb :'/habits/create_habit'
    end

    post '/habits' do 
        verify_user_logged_in
        verify_current_user
        redirect "/habits" if params[:habit] == "" #raise error if empty
            @habit = Habit.new(habit: params[:habit],user_id: @current_user.id)
            @habit.save
            redirect "/habits"
    end

    get '/habits/:id' do
        find_habit
        verify_user_logged_in
        verify_current_user
            erb :'/habits/show_habit'
      
    end

    get '/habits/:id/edit' do
        find_habit
        verify_user_logged_in
        verify_current_user
            erb :'habits/edit_habit'
       
    end

    patch '/habits/:id' do
        find_habit
        verify_user_logged_in
        
        redirect "users/#{@current_user.id}" if @current_user.id != session[:id] && params[:habit] == ""
                @habit.update(habit: params[:habit])
                redirect "/habits"

    end

    delete '/habits/:id' do
        find_habit
        verify_user_logged_in
        verify_current_user
                @habit.destroy
                redirect "/habits"
    end
    
end