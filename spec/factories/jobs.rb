FactoryBot.define do
  factory :job do
    association :account

    title { Faker::Job.title }
    location { Faker::Address.country }
  end
end
