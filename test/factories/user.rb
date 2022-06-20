FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
  factory :user do
    name {"Test User"}
    email
  end
end
