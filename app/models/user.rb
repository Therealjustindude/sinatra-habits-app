class User < ActiveRecord::Base
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    has_many :user_habits
    has_many :habits, through: :user_habits
   #create a associateted habits method

   def associated_habit?(habit)
       self.habits.include?(habit)
   end
end