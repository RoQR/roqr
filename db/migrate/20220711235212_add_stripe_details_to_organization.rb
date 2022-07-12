class AddStripeDetailsToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :stripe_customer_id, :string
    add_column :organizations, :stripe_subscription_id, :string
  end
end
