FactoryBot.define do
  factory :user do
    name { Faker::GameOfThrones.character }
    sequence :email do |n| 
      "user_#{n}@beebee.com"
    end
    password '123123'
  end
end
