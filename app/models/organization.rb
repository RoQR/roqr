class Organization < ApplicationRecord
  after_create :initialize_payment_processor
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :styles, dependent: :destroy
  pay_customer

  def email
    billing_email
  end

  def trial_days_remaining
    return 0 unless payment_processor.subscription.on_trial?

    (payment_processor.subscription.trial_ends_at - Time.zone.now).seconds.in_days.ceil
  end

  private

  def initialize_payment_processor
    set_payment_processor :stripe
    payment_processor.subscribe(plan: 'monthly1k', trial_period_days: 30)
  end
end
