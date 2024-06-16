class CreateFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :features do |t|
      
      t.integer :feature_genre_id, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
