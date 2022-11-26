class RenameDeletedAtToArchivedAt < ActiveRecord::Migration[7.0]
  def change
    rename_column :links, :deleted_at, :archived_at
  end
end
