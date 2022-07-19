class AddDeletedAtToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :deleted_at, :datetime
    add_index :links, :deleted_at
  end
end
