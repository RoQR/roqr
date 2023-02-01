# frozen_string_literal: true

class RemoveFirstScanNotifications < ActiveRecord::Migration[7.0]
  def up
    Notification.where(type: 'FirstScanNotification').destroy_all
  end

  def down
    # nothing to do
  end
end
