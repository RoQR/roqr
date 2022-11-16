class AddTransparentBackgroundToStyles < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :transparent_background, :boolean, default: false, null: false
    add_column :links, :transparent_background, :boolean, default: false, null: false
  end
end
