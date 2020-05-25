class Habit < ActiveRecord::Base
    validates :habit, uniqueness: true
    belongs_to :user
end