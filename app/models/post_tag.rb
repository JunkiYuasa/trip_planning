class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  validates :image_key, presence: true
end
