class AddPositionFieldsToStyles < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :position_border_color, :string, default: '#000000', null: false
    add_column :styles, :position_core_color, :string, default: '#000000', null: false
  end
end
