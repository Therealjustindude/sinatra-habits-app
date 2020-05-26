class UserHabits < ActiveRecord::Migration
  def change
    create_table :user_habits do |t|
      t.string :habit_id
      t.string :user_id
      
      t.timestamps null: false
    end
  end
end
