class AddBillingEmailToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :billing_email, :string
  end
end
