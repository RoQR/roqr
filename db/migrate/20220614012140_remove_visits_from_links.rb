class RemoveVisitsFromLinks < ActiveRecord::Migration[7.0]
  def change
    remove_column :links, :visits
  end
end
