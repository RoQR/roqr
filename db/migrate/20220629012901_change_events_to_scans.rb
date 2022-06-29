class ChangeEventsToScans < ActiveRecord::Migration[7.0]
  def change
    rename_table :events, :scans
  end
end
