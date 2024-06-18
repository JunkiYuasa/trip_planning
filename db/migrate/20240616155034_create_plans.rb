class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.integer :user_id, null: false
      t.integer :plan_genre_id, null: false
      t.string :name, null: false
      t.string :address
      t.text :post_url
      t.text :site_url
      t.text :remark
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.timestamps
    end
  end
end
