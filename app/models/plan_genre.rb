class PlanGenre < ApplicationRecord
  belongs_to :user
  has_many :plans

  # destroyが実行される際、下記のメソッドを実行
  before_destroy :reassign_plans_to_default_genre

  COLORS = {
    'Red' => '#FF0000',         # 赤
    'deeppink' => '#FF1493',    # ピンク
    'darkorange'=> '#FF8C00',   # オレンジ
    'gold' => '#FFD700',        # 山吹色
    'yellow' => '#FFFF00',      # 黄色
    'lime' => '#00FF00',        # 黄緑
    'green' => '#008000',       # 緑
    'indigo' => '#4B0082',      # 藍色
    'blueviolet' => '#800080',  # 紫
    'blue' => '#0000FF',        # 青
    'aqua' => '#00FFFF',        # 水色
    'black' => '#000000',       # 黒
    'gray' => '#808080',        # 灰色
  }.freeze

  validates :name, presence: true, length: { maximum: 30 }
  validates :color, presence: true

  private

  # plan_genreが削除された場合、そのplan_genreを持つplanのplan_genreを"未分類"に変更する
  def reassign_plans_to_default_genre
    default_genre = PlanGenre.find_by(name: "未分類")
    if default_genre
      plans.update_all(plan_genre_id: default_genre.id)
    end
  end

end
