# frozen_string_literal: true

class SubscriptionPayment < ApplicationRecord
  paginates_per 10
  belongs_to :subscription
  alias_attribute :subscription_payment_id, :paddle_subscription_payment_id
end
