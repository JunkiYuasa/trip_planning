class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :plan_genre
  
  
end
