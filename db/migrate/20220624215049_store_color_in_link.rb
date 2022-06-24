class StoreColorInLink < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :color, :string, null: false, default: '#000000'
    add_column :links, :fill, :string, null: false, default: '#ffffff'
  end
end
