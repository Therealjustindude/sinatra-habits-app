class Habit < ActiveRecord::Base
    has_many :user_habits 
    has_many :users, through: :user_habits
    validates :habit, uniqueness: true
end