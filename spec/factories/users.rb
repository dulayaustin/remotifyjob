FactoryBot.define do
  factory :user do
    association :account

    email_address { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    confirm_password { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
