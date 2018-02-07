FactoryBot.define do
  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    code { Faker::Lorem.word }
    password "password"
    password_confirmation "password"
  end
end