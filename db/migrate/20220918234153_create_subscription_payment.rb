class CreateSubscriptionPayment < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_payments do |t|
      t.references :subscription, foreign_key: true
      t.string :currency
      t.datetime :event_time
      t.string :payment_method
      t.string :receipt_url
      t.string :sale_gross

      t.timestamps
    end
  end
end
