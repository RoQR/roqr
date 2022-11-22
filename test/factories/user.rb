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
  end
end
