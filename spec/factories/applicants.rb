FactoryBot.define do
  factory :applicant do
    association :job

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email_address { Faker::Internet.unique.email }
    stage { "application" }
    status { "active" }
  end
end
