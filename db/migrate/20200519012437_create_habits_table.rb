class CreateHabitsTable < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.string :habit

      t.timestamps null: false
    end
  end
end
