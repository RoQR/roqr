class DropSubscriptionColumnsFromOrganization < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :paddle_subscription_id, :integer
    remove_column :organizations, :paddle_update_url, :string
    remove_column :organizations, :paddle_cancel_url, :string
    remove_column :organizations, :paddle_status, :string
    remove_column :organizations, :paddle_next_bill_date, :datetime
  end
end
