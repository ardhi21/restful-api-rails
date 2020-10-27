FactoryBot.define do
  factory :hospital do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    location { Faker::Address.latitude }
  end
end
