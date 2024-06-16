class CreateFeaturePurposes < ActiveRecord::Migration[6.1]
  def change
    create_table :feature_purposes do |t|
      
      t.integer :feature_id, null: false
      t.integer :purpose_id, null: false
      t.timestamps
    end
  end
end
