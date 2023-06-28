# frozen_string_literal: true

class Subscription < ApplicationRecord
  after_destroy_commit :cancel_paddle_subscription
  belongs_to :organization
  has_many :subscription_payments, dependent: :destroy
  alias_attribute :subscription_id, :paddle_subscription_id
  enum status: {active: "active", trialing: "trialing", past_due: "past_due", paused: "paused", cancelled: "deleted"}

  def cancel_paddle_subscription
    CancelPaddleSubscriptionJob.perform_later(subscription_id) unless cancelled?
  end

  def subscribed?
    %w[active trialing
      past_due].include?(status) || (cancelled? && cancellation_effective_date > Time.zone.now)
  end
end
