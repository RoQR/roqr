class RenameQrConcepts < ActiveRecord::Migration[7.0]
  def change
    rename_column :styles, :fill, :background_color
    rename_column :styles, :color, :dots_color
    rename_column :styles, :position_core_color, :corner_dots_color
    rename_column :styles, :position_border_color, :corner_squares_color
    rename_column :links, :fill, :background_color
    rename_column :links, :color, :dots_color
    rename_column :links, :position_core_color, :corner_dots_color
    rename_column :links, :position_border_color, :corner_squares_color
  end
end
