class Habit < ActiveRecord::Base
    validates :habit, uniqueness: true
    has_many :user_habits 
    has_many :users, through: :user_habits
end