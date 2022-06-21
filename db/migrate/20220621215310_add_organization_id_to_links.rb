class AddOrganizationIdToLinks < ActiveRecord::Migration[7.0]
  def change
    add_reference :links, :organization, type: :uuid
  end
end
