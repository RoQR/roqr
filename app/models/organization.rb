class Organization < ApplicationRecord
  after_create :initialize_payment_processor
  has_many :users
  has_many :links, dependent: :destroy
  pay_customer

  def email
    billing_email
  end

  private

  def initialize_payment_processor
    set_payment_processor :stripe
  end
end
