# frozen_string_literal: true

class MoveSubscriptionsToSubscriptionTable < ActiveRecord::Migration[7.0]
  def up
    Organization.all.each do |o|
      next unless o.paddle_subscription_id

      o.build_subscription(
        {
          subscription_id: o.paddle_subscription_id,
          update_url: o.paddle_update_url,
          cancel_url: o.paddle_cancel_url,
          status: o.paddle_status,
          next_bill_date: o.paddle_next_bill_date,
          subscription_plan_id: 334_228
        }
      )
      o.save
    end
  end

  def down
    Subscription.all.each do |s|
      s.organization.update(
        {
          paddle_subscription_id: s.subscription_id,
          paddle_update_url: s.update_url,
          paddle_cancel_url: s.cancel_url,
          paddle_status: s.status,
          paddle_next_bill_date: s.next_bill_date
        }
      )
      s.delete
    end
  end
end
