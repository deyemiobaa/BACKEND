# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

two_months_ago = Date.today - 90

last_month = Date.today - 1.month

today = Date.today


10.times do
    Api::V1::Memory.create(
      prompt: Faker::Lorem.sentence,
      story: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence,
      public: Faker::Boolean.boolean,
      favorite: Faker::Boolean.boolean,
      user_id: "a067f2e7-5991-4660-b69c-ae9ac72d1a4a",
      created_at: Faker::Date.between(from: last_month, to: today)
    )
end

10.times do
    Api::V1::Memory.create(
      prompt: Faker::Lorem.sentence,
      story: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence,
      public: Faker::Boolean.boolean,
      favorite: Faker::Boolean.boolean,
      user_id: "a067f2e7-5991-4660-b69c-ae9ac72d1a4a",
      created_at: Faker::Date.between(from: two_months_ago, to: last_month)
    )
end

puts "Seeded #{Api::V1::Memory.count} memories"