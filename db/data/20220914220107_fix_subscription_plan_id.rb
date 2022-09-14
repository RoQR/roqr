# frozen_string_literal: true

class FixSubscriptionPlanId < ActiveRecord::Migration[7.0]
  def up
    Subscription.where(subscription_plan_id: 334_228).each do |s|
      s.subscription_plan_id = 34_458
      s.save
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
