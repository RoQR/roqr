# frozen_string_literal: true

FactoryBot.define do
  factory :public_page do
    name { 'Public page' }
    organization
  end
end
