class Category < ApplicationRecord

  belongs_to :purpose
  has_many :posts

  validates :purpose_id, presence: true
  validates :name, presence: true, length: { maximum: 15 }

end
