class RemoveIpTracking < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :ip
  end
end
