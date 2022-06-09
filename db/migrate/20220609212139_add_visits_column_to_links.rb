class AddVisitsColumnToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :visits, :int, default: 0, null: false
  end
end
