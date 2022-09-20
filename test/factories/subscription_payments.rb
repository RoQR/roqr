FactoryBot.define do
  factory :subscription_payment do
    subscription { nil }
    currency { 'MyString' }
    event_time { '2022-09-15 09:26:48' }
    payment_method { 'MyString' }
    receipt_url { 'MyString' }
    sale_gross { 'MyString' }
  end
end
