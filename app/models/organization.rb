# frozen_string_literal: true

class Organization < ApplicationRecord
  before_create :setup_trial
  after_create_commit :schedule_trial_emails
  has_many :custom_domains, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_one :subscription, dependent: :destroy
  delegate :status, to: :subscription, prefix: :subscription, allow_nil: true
  delegate :cancelled?, to: :subscription, prefix: :subscription, allow_nil: true
  delegate :subscribed?, to: :subscription, allow_nil: true
  delegate :cancellation_effective_date, to: :subscription, allow_nil: true
  validates :billing_email, presence: true, email: true

  def email
    billing_email
  end

  def trial_days_remaining
    [(trial_ends_at - Time.zone.now).seconds.in_days.ceil, 0].max
  end

  def on_trial?
    !subscribed? && trial_days_remaining.positive?
  end

  def on_trial_or_subscribed?
    on_trial? || subscribed?
  end

  def setup_trial
    self.trial_ends_at = 30.days.from_now
  end

  def schedule_trial_emails
    SubscriptionMailer.with(user: users.first).delay(run_at: trial_ends_at).trial_ended
  end
end
