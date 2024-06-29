class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :plan_genre

  validates :plan_genre_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :address, length: { maximum: 60 }
  validates :remark, length: { maximum: 400 }
  validates :start_time, presence: true
  validates :end_time, presence: true

# プランジャンルの色を取得
  def color
    plan_genre.color
  end
end
