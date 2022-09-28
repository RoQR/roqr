# frozen_string_literal: true

class SubscriptionPayment < ApplicationRecord
  belongs_to :subscription
  alias_attribute :subscription_payment_id, :paddle_subscription_payment_id
end
