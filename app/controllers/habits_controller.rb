class HabitsController < ApplicationController
   
    get '/habits' do
        verify_user_logged_in
            erb :"habits/habits_index"            
    end

    get '/habits/new' do
        verify_user_logged_in
    
        @habits = Habit.all
        erb :'/habits/create_habit'
    end

    post '/habits' do 
        verify_user_logged_in
        @current_user.habits << Habit.find(params[:habit_id]) if params[:habit_id]
        
        @habit = Habit.new(habit: params[:habit].downcase) if params[:habit] && params[:habit] != ""
        
        if @habit && @habit.save
            @current_user.habits << @habit  
        end
        redirect "/habits" 
    end

    get '/habits/:id' do
        verify_user_logged_in
        if !find_habit 
             flash[:message] = "You have not created this habit yet."
             redirect "/habits" 
        end
        # binding.pry
        verify_habits_permission 

         erb :'/habits/show_habit' 
    end

    get '/habits/:id/edit' do
        if !find_habit
            flash[:message] = "You have not created this habit yet."
            redirect "/habits" 
       end
        verify_user_logged_in
        verify_habits_permission
        erb :'habits/edit_habit'
       
    end

    patch '/habits/:id' do
        verify_user_logged_in
        redirect "users/#{@current_user.id}" if params[:habit] == ""
        @habit.update(habit: params[:habit].downcase)
        redirect "/habits"
    end

    delete '/habits/:id' do
        if !find_habit
            flash[:message] = "You have not created this habit yet."
            redirect "/habits" 
        end
        verify_user_logged_in
        verify_habits_permission  
        @habit.destroy
        redirect "/habits"
    end
    
end