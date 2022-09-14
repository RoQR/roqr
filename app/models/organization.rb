class Organization < ApplicationRecord
  before_create :setup_trial
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :public_pages, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_one :subscription, dependent: :destroy

  def email
    billing_email
  end

  def trial_days_remaining
    [(trial_ends_at - Time.zone.now).seconds.in_days.ceil, 0].max
  end

  def on_trial?
    !subscribed? && trial_days_remaining.positive?
  end

  def cancelled?
    paddle_status == 'cancelled'
  end

  def subscribed?
    %w[active trialing past_due].include?(paddle_status) || (cancelled? && cancellation_effective_date > Time.zone.now)
  end

  def past_due?
    paddle_status == 'past_due'
  end

  def paused?
    paddle_status == 'paused'
  end

  def on_trial_or_subscribed?
    on_trial? || subscribed?
  end

  def setup_trial
    self.trial_ends_at = 30.days.from_now
  end
end
