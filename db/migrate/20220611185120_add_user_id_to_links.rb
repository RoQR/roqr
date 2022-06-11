class AddUserIdToLinks < ActiveRecord::Migration[7.0]
  def change
    add_reference :links, :user, type: :uuid, index: true 
  end
end
