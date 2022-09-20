# frozen_string_literal: true

json.extract! subscription_payment, :id, :subscription_id, :currency, :event_time, :payment_method, :receipt_url,
              :sale_gross, :created_at, :updated_at
json.url subscription_payment_url(subscription_payment, format: :json)
