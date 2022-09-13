class AddDotsShapeToStylesAndLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :dots_shape, :string, null: false, default: 'square'
    add_column :links, :dots_shape, :string, null: false, default: 'square'
  end
end
