class Feature < ApplicationRecord
  belongs_to :feature_genre
  
  #多対多の関連付け
  has_many :feature_purposes, dependent: :destroy
  has_many :purposes, through: :feature_purposes
  
  has_many :post_features, dependent: :destroy
  has_many :features, through: :post_features
  
end
