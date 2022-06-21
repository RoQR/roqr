class AddOrganizationIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :organization, type: :uuid
  end
end
