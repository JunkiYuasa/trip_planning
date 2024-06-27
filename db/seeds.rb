# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user = User.find_or_create_by!(email: 'tripla@example.com') do |user|
  user.name = 'とりぷら'
  user.password = 'ojunjun'
end

Admin.find_or_create_by!(email: 'tripla@example.com') do |admin|
  admin.password = 'ojunjun'
end

Purpose.find_or_create_by!(name: '食事')
Purpose.find_or_create_by!(name: '観光')
Purpose.find_or_create_by!(name: '宿泊')

Category.find_or_create_by!(purpose_id: Purpose.find_by(name: '食事').id, name: "スイーツ")
Category.find_or_create_by!(purpose_id: Purpose.find_by(name: '食事').id, name: "焼肉")
Category.find_or_create_by!(purpose_id: Purpose.find_by(name: '観光').id, name: "神社")
Category.find_or_create_by!(purpose_id: Purpose.find_by(name: '観光').id, name: "絶景スポット")
Category.find_or_create_by!(purpose_id: Purpose.find_by(name: '宿泊').id, name: "ビジネスホテル")
Category.find_or_create_by!(purpose_id: Purpose.find_by(name: '宿泊').id, name: "リゾートホテル")

FeatureGenre.find_or_create_by!(name: "アクセス")
FeatureGenre.find_or_create_by!(name: "サービス")
FeatureGenre.find_or_create_by!(name: "シチュエーション")

Feature.find_or_create_by!(name: "駅から徒歩5分以内") do |feature|
  feature.feature_genre_id = FeatureGenre.find_by(name: 'シチュエーション').id
  feature.purpose_ids = Purpose.where(name: ['食事', '観光', '宿泊']).pluck(:id)
end
Feature.find_or_create_by!(name: "駅から徒歩10分以内") do |feature|
  feature.feature_genre_id = FeatureGenre.find_by(name: 'シチュエーション').id
  feature.purpose_ids = Purpose.where(name: ['食事', '観光', '宿泊']).pluck(:id)
end
Feature.find_or_create_by!(name: "初回割引") do |feature|
  feature.feature_genre_id = FeatureGenre.find_by(name: 'サービス').id
  feature.purpose_ids = Purpose.where(name: ['食事', '観光', '宿泊']).pluck(:id)
end
Feature.find_or_create_by!(name: "カップルにおすすめ") do |feature|
  feature.feature_genre_id = FeatureGenre.find_by(name: 'シチュエーション').id
  feature.purpose_ids = Purpose.where(name: ['食事', '観光', '宿泊']).pluck(:id)
end

PlanGenre.find_or_create_by!(user_id: admin_user.id, name: '未分類') do |genre|
  genre.color = '#000000'
  genre.standard = true
end

PlanGenre.find_or_create_by!(user_id: admin_user.id, name: '食事') do |genre|
  genre.color = '#FF0000'
  genre.standard = true
end

PlanGenre.find_or_create_by!(user_id: admin_user.id, name: '観光') do |genre|
  genre.color = '#800080'
  genre.standard = true
end

PlanGenre.find_or_create_by!(user_id: admin_user.id, name: '宿泊') do |genre|
  genre.color = '#0000FF'
  genre.standard = true
end
