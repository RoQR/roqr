class RenameNameToSsid < ActiveRecord::Migration[7.0]
  def change
    rename_column :wifi_links, :name, :ssid
  end
end
