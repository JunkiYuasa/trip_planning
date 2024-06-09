class CreatePostFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :post_features do |t|
      
      t.integer :post_id, null: false
      t.integer :feature_id, null: false

      t.timestamps
    end
  end
end
