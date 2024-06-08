class FeatureGenre < ApplicationRecord
  has_many :features, dependent: :destroy
end
