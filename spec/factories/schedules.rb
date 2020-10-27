FactoryBot.define do
  factory :schedule do
    date { Faker::Date.in_date_period }
    start_time { "2020-10-27 10:06:17" }
    end_time { "2020-10-27 12:06:17" }
    doctor { nil }
    hospital { nil }
  end
end
