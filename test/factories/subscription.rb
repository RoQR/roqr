# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    paddle_subscription_id { 2 }
    subscription_plan_id { 2 }
    organization
    update_url { "https://sandbox-checkout.paddle.com/subscription/update?user=2&subscription=5&hash=c3305e89ab2ceaaf19813d586fc47edf5769bb63" }
    cancel_url { "https://sandbox-checkout.paddle.com/subscription/cancel?user=2&subscription=5&hash=04745e68a1df96c15b11eb93a53b3381eae77fa9" }
    status { "active" }
    next_bill_date { Time.zone.now + 30.days }
    paused_at { nil }
    paused_from { nil }
    paused_reason { nil }
    cancellation_effective_date { nil }
  end

  trait :cancelled do
    cancellation_effective_date { Time.zone.now }
    status { "deleted" }
  end

  trait :past_due do
    status { "past_due" }
  end

  trait :paused do
    status { "paused" }
    paused_at { Time.zone.now }
    paused_from { Time.zone.now }
    paused_reason { "delinquent" }
  end
end
