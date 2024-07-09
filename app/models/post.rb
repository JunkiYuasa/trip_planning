class Post < ApplicationRecord

  belongs_to :user
  belongs_to :purpose
  belongs_to :category, optional: true
  has_many :favorites, dependent: :destroy

  #多対多の関連付け
  has_many :post_features, dependent: :destroy
  has_many :features, through: :post_features
  has_many :comments, dependent: :destroy

  #画像の複数枚投稿を可能にし、それぞれの画像にタグをつける
  has_many_attached :images
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :purpose_id, presence: true
  validates :name, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :introduction, length: { maximum: 400 }
  validates :address, length: { maximum: 60 }

  validate :images_format

  def images_format
    images.each do |image|
      if !image.blob.content_type.in?(%w(image/png image/jpg image/jpeg))
        errors.add(:images, 'must be a PNG or JPG/JPEG file')
        #image.purge # アップロードをキャンセル
      end
    end
  end

# ユーザーがその投稿に対していいねをしているか
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


end
