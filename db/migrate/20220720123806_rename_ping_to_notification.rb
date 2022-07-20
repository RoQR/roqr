class RenamePingToNotification < ActiveRecord::Migration[7.0]
  def change
    rename_table :pings, :notifications
  end
end
