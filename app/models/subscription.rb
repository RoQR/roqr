class Subscription < ApplicationRecord
  after_destroy_commit :cancel_paddle_subscription
  belongs_to :organization
  alias_attribute :subscription_id, :paddle_subscription_id

  def cancel_paddle_subscription
    PaddlePay::Subscription::User.cancel(subscription_id) unless status == 'deleted'
  end
end
