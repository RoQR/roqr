# frozen_string_literal: true

class SubscriptionPayment < ApplicationRecord
  belongs_to :subscription
end
