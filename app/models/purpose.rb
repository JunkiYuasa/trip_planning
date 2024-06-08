class Purpose < ApplicationRecord
  
  has_many :categories
  
  #多対多の関連付け
  has_many :feature_purposes
  has_many :features, through: :feature_purposes
  
end
