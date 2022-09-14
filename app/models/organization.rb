class Organization < ApplicationRecord
  before_create :setup_trial
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :public_pages, dependent: :destroy
  has_many :styles, dependent: :destroy

  def email
    billing_email
  end

  def trial_days_remaining
    [(trial_ends_at - Time.zone.now).seconds.in_days.ceil, 0].max
  end

  def on_trial?
    trial_days_remaining.positive?
  end

  def on_trial_or_subscribed?
    on_trial?
  end

  def setup_trial
    self.trial_ends_at = 30.days.from_now
  end
end
