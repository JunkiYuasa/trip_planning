class FeatureGenre < ApplicationRecord
  has_many :features, dependent: :destroy

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
end
