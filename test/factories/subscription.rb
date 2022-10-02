# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    paddle_subscription_id { 2 }
    subscription_plan_id { 2 }
    organization
    update_url { 'https://google.com' }
    cancel_url { 'https://google.com' }
    status { 'active' }
    next_bill_date { Time.zone.now + 30.days }
    paused_at { nil }
    paused_from { nil }
    paused_reason { nil }
    cancellation_effective_date { nil }
  end
end
