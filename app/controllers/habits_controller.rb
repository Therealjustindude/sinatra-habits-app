class HabitsController < ApplicationController
   
    get '/habits' do
        verify_user_logged_in
            erb :"habits/habits_index"            
    end

    get '/habits/new' do
        verify_user_logged_in
             erb :'/habits/create_habit'
    end

    post '/habits' do 
        verify_user_logged_in
        if params[:habit] == "" 
            flash[:message] = "Please do not leave Habit blank"
            redirect "/habits" 
        #add elsif for habit_id find and associate with user
        else
            @habit = Habit.new(habit: params[:habit].downcase)
            if @habit.save
                @current_user.habits << @habit
                redirect "/habits"
            else
                flash[:message] = "You created this habit already."
                redirect "/habits" 
            end
        end
    end

    get '/habits/:id' do

        if !find_habit
            flash[:message] = "You have not created this habit yet."
            redirect "/habits" 
        end 
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
        find_habit
        verify_user_logged_in
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