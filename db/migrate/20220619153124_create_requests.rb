class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :requestable_type
      t.integer :method

      t.timestamps
    end
  end
end
