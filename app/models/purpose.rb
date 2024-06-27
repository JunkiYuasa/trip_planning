class Purpose < ApplicationRecord

  has_many :categories
  has_many :posts

  #多対多の関連付け
  has_many :feature_purposes
  has_many :features, through: :feature_purposes

  validates :name, presence: true

end
