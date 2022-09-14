class Organization < ApplicationRecord
  after_create :initialize_payment_processor
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :public_pages, dependent: :destroy
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
    set_payment_processor :fake_processor, allow_fake: true
    payment_processor.subscribe(trial_ends_at: 30.days.from_now, ends_at: 30.days.from_now)
  end
end
