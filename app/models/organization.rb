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
    set_payment_processor :stripe
    payment_processor.subscribe(plan: 'price_1LJGVuKEEF3z117yBoHSZZuo', trial_period_days: 90)
  end
end
