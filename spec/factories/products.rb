FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { rand(100..200) * 10 }
    discount { rand(20..80) }
  end
end
