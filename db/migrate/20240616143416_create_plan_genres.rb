class CreatePlanGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_genres do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :color, null: false
      t.boolean :standard, null: false, default: false
      t.timestamps
    end
  end
end
