class DropSubscriptionColumnsFromOrganization < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :paddle_subscription_id
    remove_column :organizations, :paddle_update_url
    remove_column :organizations, :paddle_cancel_url
    remove_column :organizations, :paddle_status
    remove_column :organizations, :paddle_next_bill_date
  end
end
