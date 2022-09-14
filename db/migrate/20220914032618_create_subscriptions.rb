class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.integer :paddle_subscription_id, null: false
      t.integer :subscription_plan_id, null: false
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :update_url, null: false
      t.string :cancel_url, null: false
      t.string :status, null: false
      t.datetime :next_bill_date
      t.datetime :paused_at
      t.datetime :paused_from
      t.string :paused_reason
      t.datetime :cancellation_effective_date

      t.timestamps
    end
  end
end
