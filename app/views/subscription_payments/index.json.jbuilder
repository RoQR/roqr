# frozen_string_literal: true

json.array! @subscription_payments, partial: 'subscription_payments/subscription_payment', as: :subscription_payment
