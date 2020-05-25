class HabitsController < ApplicationController
   #read
    get '/habits' do
        verify_user_logged_in
        # verify_current_user_habits
            @habits = @current_user.habits
            erb :"habits/habits_index"            
    end

    get '/habits/new' do
        verify_user_logged_in

             erb :'/habits/create_habit'
    end

    post '/habits' do 
        if params[:habit] == "" 
            flash[:message] = "Please do not leave Habit blank"
            redirect "/habits" 
        else
            @habit = Habit.new(habit: params[:habit].downcase,user_id: @current_user.id)
            @habit.save
            redirect "/habits"
        end
    end

    get '/habits/:id' do
        find_habit
        verify_user_logged_in
        verify_habits_permission
            erb :'/habits/show_habit'
      
    end

    get '/habits/:id/edit' do
        find_habit
        verify_user_logged_in
        verify_habits_permission
            erb :'habits/edit_habit'
       
    end

    patch '/habits/:id' do
        # find_habit
        # verify_user_logged_in
        # verify_habits_permission
        redirect "users/#{@current_user.id}" if params[:habit] == ""
                @habit.update(habit: params[:habit].downcase)
                redirect "/habits"

    end

    delete '/habits/:id' do
        find_habit
        verify_user_logged_in
        verify_habits_permission  
                @habit.destroy
                redirect "/habits"
    end
    
end