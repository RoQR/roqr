class AddImageToStylesAndLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :image_url, :string
    add_column :links, :image_url, :string
  end
end
