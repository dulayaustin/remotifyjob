FactoryBot.define do
  factory :applicant do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    stage { "MyString" }
    status { "MyString" }
    job { nil }
  end
end
