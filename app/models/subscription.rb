# frozen_string_literal: true

class Subscription < ApplicationRecord
  after_destroy_commit :cancel_paddle_subscription
  belongs_to :organization
  has_many :subscription_payments, dependent: :destroy
  alias_attribute :subscription_id, :paddle_subscription_id

  def cancel_paddle_subscription
    PaddlePay::Subscription::User.cancel(subscription_id) unless status == 'deleted'
  end

  def cancelled?
    status == 'deleted'
  end

  def past_due?
    status == 'past_due'
  end

  def paused?
    status == 'paused'
  end

  def subscribed?
    %w[active trialing
       past_due].include?(status) || (cancelled? && cancellation_effective_date > Time.zone.now)
  end
end
