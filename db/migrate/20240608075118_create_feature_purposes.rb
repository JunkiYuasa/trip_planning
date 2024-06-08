class CreateFeaturePurposes < ActiveRecord::Migration[6.1]
  def change
    create_table :feature_purposes do |t|
      
      t.integer :feature_id
      t.integer :purpose_id
      t.timestamps
    end
  end
end
