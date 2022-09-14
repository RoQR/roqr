class AddPaddleFieldsToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :paddle_subscription_id, :integer
    add_column :organizations, :paddle_update_url, :text
    add_column :organizations, :paddle_cancel_url, :text
    add_column :organizations, :paddle_status, :text
    add_column :organizations, :paddle_next_bill_date, :datetime
  end
end
