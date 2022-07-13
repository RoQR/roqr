class Organization < ApplicationRecord
  after_create :initialize_payment_processor
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :styles, dependent: :destroy
  pay_customer

  def email
    billing_email
  end

  private

  def initialize_payment_processor
    time = 30.days.from_now
    set_payment_processor :fake_processor, allow_fake: true
    payment_processor.subscribe(trial_ends_at: time, ends_at: time)
  end
end
