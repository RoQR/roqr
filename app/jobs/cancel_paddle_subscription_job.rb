# frozen_string_literal: true

class CancelPaddleSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(subscription_id)
    PaddlePay::Subscription::User.cancel(subscription_id)
  end
end
