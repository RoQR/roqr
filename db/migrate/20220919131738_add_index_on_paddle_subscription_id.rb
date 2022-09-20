# frozen_string_literal: true

class AddIndexOnPaddleSubscriptionId < ActiveRecord::Migration[7.0]
  def change
    add_index :subscriptions, :paddle_subscription_id
  end
end
