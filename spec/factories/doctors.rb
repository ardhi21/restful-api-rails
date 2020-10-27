FactoryBot.define do
  factory :doctor do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    address { Faker::Address.street_name }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
  end
end
