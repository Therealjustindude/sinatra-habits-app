class UserHabit < ActiveRecord::Base
    belongs_to :user 
    belongs_to :habit
end