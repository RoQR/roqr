class CreateSubscriptionPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_payments, id: :uuid do |t|
      t.references :subscription, null: false, foreign_key: true, type: :uuid
      t.string :currency
      t.datetime :event_time
      t.string :payment_method
      t.string :receipt_url
      t.string :sale_gross

      t.timestamps
    end
  end
end
