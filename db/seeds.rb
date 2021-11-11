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

User.create(full_name: 'unverified user', email: 'unverifed@test.pl', password: 'zaq1',
            slack_register_id: "#{(0...6).map { (65 + rand(26)).chr }.join}", slack_id: 'xxxx', id: 0)

User.create(full_name: 'Marcin Koper', email: 'marcin.koper@test.pl', password: 'zaq1',
            slack_register_id: "#{(0...6).map { (65 + rand(26)).chr }.join}", slack_id: 'xxxy')

3.times do |i|
  User.create(full_name: "User#{i}", email: "user#{i}@test.pl", password: 'zaq1',
              slack_register_id: "#{(0...6).map { (65 + rand(26)).chr }.join}", slack_id: "xxx#{i}" )
end


# 5.times do |i|
#   History.create(spot_id: i, user_id: i)
# end
#
# 15.times do |i|
#   History.create(spot_id: i, user_id: 1)
# end