class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :plan_genre

  def color
    plan_genre.color
  end
end
