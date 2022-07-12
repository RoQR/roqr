class Organization < ApplicationRecord
  after_create_commit :initialize_stripe
  after_update_commit :update_stripe, if: :should_update_stripe?
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :styles, dependent: :destroy

  def customer
    @customer ||= Stripe::Customer.retrieve(stripe_customer_id)
  end

  def subscription
    @subscription ||= Stripe::Subscription.retrieve(stripe_subscription_id)
  end
  
  def on_trial?
    subscription.trial_end > Time.zone.now.to_i
  end

  private

  def initialize_stripe
    StripeService.initialize_organization(self)
  end

  def should_update_stripe?
    saved_change_to_billing_email? || saved_change_to_name?
  end

  def update_stripe
    StripeService.update_organization(self)
  end
end
