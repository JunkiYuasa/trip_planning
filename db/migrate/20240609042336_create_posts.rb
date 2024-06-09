class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, null: false
      t.integer :purpose_id, null: false
      t.integer :category_id
      t.string :title, null: false
      t.string :name, null: false
      t.text :introduction
      t.text :address
      t.integer :min_fee
      t.integer :max_fee
      t.text :site_url

      t.timestamps
    end
  end
end
