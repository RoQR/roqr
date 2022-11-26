# frozen_string_literal: true

FactoryBot.define do
  sequence :billing_email do |n|
    "test#{n}@example.com"
  end
  factory :organization do
    name { "MyString" }
    billing_email
  end
end
