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
       
        found_habit= Habit.find_by_id(params[:habit_id])
        
        @current_user.habits << found_habit if found_habit && !(@current_user.associated_habit?(found_habit))
        
        new_habit = Habit.new(habit: params[:habit].downcase) if params[:habit].present?
        
        if new_habit && new_habit.save
            @current_user.habits << new_habit if !(@current_user.associated_habit?(new_habit))
        end
        
        redirect "/habits" 
    end

    get '/habits/:id' do
        verify_user_logged_in

        if !find_habit 
             flash[:message] = "You have not created this habit yet."
             redirect "/habits" 
        end
       
        if @current_user.associated_habit?(@habit)
            erb :'habits/edit_habit'
        else
            flash[:message] = "You have not created this habit yet."
            redirect "/habits" 
        end 
    end

    get '/habits/:id/edit' do
        verify_user_logged_in

        if !find_habit
            flash[:message] = "You have not created this habit yet."
            redirect "/habits" 
        end

       if @current_user.associated_habit?(@habit)
        erb :'habits/edit_habit'
       else
        flash[:message] = "You have not created this habit yet."
        redirect "/habits" 
       end 
    end

    patch '/habits/:id' do
    
        verify_user_logged_in
        habit = Habit.find_by_id(params[:id]) 
        if !(params[:habit].present?)
            flash[:error] = "Do not leave blank"
            redirect "/habits/#{habit.id}"
        end
        habit.update(habit: params[:habit])
        redirect "/habits"
        
       
        
    end

    delete '/habits/:id' do
        verify_user_logged_in

        if !find_habit
            flash[:message] = "You have not created this habit yet."
            redirect "/habits" 
        end
        user_habit = UserHabit.find_by(habit_id: @habit.id)
        user_habit.destroy
        redirect "/habits"
    end
    
    
end