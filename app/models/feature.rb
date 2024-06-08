class Feature < ApplicationRecord
  belongs_to :feature_genre
  
  #多対多の関連付け
  has_many :feature_purposes, dependent: :destroy
  has_many :purposes, through: :feature_purposes
  
end
