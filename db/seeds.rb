# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do |i|
  Spot.create(name: "A#{i}", reserved: false)
end

10.times do |i|
  Spot.create(name: "B#{i}", reserved: false)
end

5.times do |i|
  User.create(username: "User#{i}", email: "User#{i}@test.pl", password: 'testpassword', slack_id: "XDSDS34")
end

5.times do |i|
  History.create(spot_id: i, user_id: i)
end

15.times do |i|
  History.create(spot_id: i, user_id: 1)
end