class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :purpose  
  belongs_to :category
  
  #多対多の関連付け
  has_many :post_features, dependent: :destroy
  has_many :features, through: :post_features
  
  has_many_attached :images
  
end
