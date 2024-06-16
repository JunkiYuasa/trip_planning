# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "tripla@0726",
  password: "ojunjun"
)

Purpose.create!(name: "食事")
Purpose.create!(name: "観光")
Purpose.create!(name: "宿泊")