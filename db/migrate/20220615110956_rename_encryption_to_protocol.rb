class RenameEncryptionToProtocol < ActiveRecord::Migration[7.0]
  def change
    rename_column :wifi_links, :encryption, :protocol
  end
end
