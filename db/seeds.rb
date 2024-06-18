# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'ex', email: 'user@example.com', password: "example")

Admin.create!(email: "tripla@example.com", password: "ojunjun")

Purpose.create!(name: "食事")
Purpose.create!(name: "観光")
Purpose.create!(name: "宿泊")

# default: trueにすることで編集と削除を出来ないようにする
PlanGenre.create!(name: "未分類", color: "#000000", standard: true) # 黒
PlanGenre.create!(name: '食事', color: '#FFA500', standard: true)   # オレンジ
PlanGenre.create!(name: '観光', color: '#FFFF00', standard: true)   # 黄色
PlanGenre.create!(name: '宿泊', color: '#008000', standard: true)   # 緑
