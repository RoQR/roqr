class LinkNameUniqueness < ActiveRecord::Migration[7.0]
  def change
    add_index :links, [:name, :organization_id], unique: true
  end
end
