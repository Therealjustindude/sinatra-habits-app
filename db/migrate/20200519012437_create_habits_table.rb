class CreateHabitsTable < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.string :habit
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
