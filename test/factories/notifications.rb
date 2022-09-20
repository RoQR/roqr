# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { nil }
    type { '' }
    params { '' }
    read_at { '2022-07-19 22:25:29' }
  end
end
