class RemovePay < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key 'pay_charges', 'pay_customers', column: 'customer_id'
    remove_foreign_key 'pay_charges', 'pay_subscriptions', column: 'subscription_id'
    remove_foreign_key 'pay_payment_methods', 'pay_customers', column: 'customer_id'
    remove_foreign_key 'pay_subscriptions', 'pay_customers', column: 'customer_id'
    remove_foreign_key 'public_pages', 'organizations'
    remove_foreign_key 'requests', 'users'
    remove_foreign_key 'styles', 'organizations'
    drop_table :pay_charges, cascade: true
    drop_table :pay_customers
    drop_table :pay_merchants
    drop_table :pay_payment_methods
    drop_table :pay_subscriptions
    drop_table :pay_webhooks
  end
end
