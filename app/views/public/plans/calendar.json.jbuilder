json.array!(@plans) do |plan|
  json.id plan.id
  json.user_id plan.user_id
  json.plan_genre_id plan.plan_genre_id
  json.plan_genre do
    json.color plan.plan_genre.color
  end
  json.name plan.name
  json.start_time plan.start_time.in_time_zone('Tokyo')
  json.end_time plan.end_time.in_time_zone('Tokyo')
end