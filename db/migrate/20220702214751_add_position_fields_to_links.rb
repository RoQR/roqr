class AddPositionFieldsToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :position_border_color, :string, default: "#000000", null: false
    add_column :links, :position_core_color, :string, default: "#000000", null: false
  end
end
