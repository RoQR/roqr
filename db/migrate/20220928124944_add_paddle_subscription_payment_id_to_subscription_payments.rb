class AddPaddleSubscriptionPaymentIdToSubscriptionPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_payments, :paddle_subscription_payment_id, :integer, index: true
  end
end
