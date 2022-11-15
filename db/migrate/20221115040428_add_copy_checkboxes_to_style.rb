class AddCopyCheckboxesToStyle < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :corner_squares_copy_dots, :boolean, default: true, null: false
    add_column :styles, :corner_dots_copy_dots, :boolean, default: true, null: false
  end
end
