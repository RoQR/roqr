# frozen_string_literal: true

FactoryBot.define do
  factory :subscription_payment do
    subscription
    currency { "USD" }
    event_time { Time.zone.now }
    payment_method { "card" }
    receipt_url { "https://my.paddle.com/receipt/2/efa7376eb503e2f-34b1566919" }
    sale_gross { "9.99" }
  end
end
