class AddCornerShapes < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :corner_squares_shape, :string, null: false, default: ''
    add_column :links, :corner_squares_shape, :string, null: false, default: ''
    add_column :styles, :corner_dots_shape, :string, null: false, default: ''
    add_column :links, :corner_dots_shape, :string, null: false, default: ''
  end
end
