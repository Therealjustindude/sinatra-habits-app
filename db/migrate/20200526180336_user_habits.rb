class UserHabits < ActiveRecord::Migration
  def change
    create_table :user_habits do |t|
      t.integer :habit_id
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
