class Category < ApplicationRecord
  
  belongs_to :purpose
  has_many :posts
  
end
