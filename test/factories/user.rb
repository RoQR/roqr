# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
  factory :user do
    name { "Test User" }
    email
    organization
    role { "administrator" }
    password { "Aa1!xxxx" }
    confirmed_at { Time.now }
    terms_accepted { true }
  end
  trait :unconfirmed do
    confirmed_at { nil }
    terms_accepted { false }
  end
end
