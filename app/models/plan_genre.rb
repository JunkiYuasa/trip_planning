class PlanGenre < ApplicationRecord
  belongs_to :user
  has_many :plans

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

  # validates :color, inclusion: { in: COLORS.values }

end
