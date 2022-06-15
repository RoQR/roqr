class CreateWifiLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :wifi_links, id: :uuid do |t|
      t.string :name
      t.string :password
      t.boolean :hidden
      t.string :encryption

      t.timestamps
    end
  end
end
