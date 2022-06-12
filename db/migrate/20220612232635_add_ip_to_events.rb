class AddIpToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :ip, :inet
  end
end
