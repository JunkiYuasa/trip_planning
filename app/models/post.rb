class Post < ApplicationRecord

  belongs_to :user
  belongs_to :purpose
  belongs_to :category
  has_many :favorites, dependent: :destroy

  #多対多の関連付け
  has_many :post_features, dependent: :destroy
  has_many :features, through: :post_features
  has_many :comments, dependent: :destroy

  #画像の複数枚投稿を可能に
  has_many_attached :images

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
