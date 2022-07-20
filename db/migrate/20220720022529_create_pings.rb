class CreatePings < ActiveRecord::Migration[7.0]
  def change
    create_table :pings, id: :uuid do |t|
      t.references :recipient, polymorphic: true, null: false, type: :uuid
      t.string :type, null: false
      t.jsonb :params
      t.datetime :read_at

      t.timestamps
    end
    add_index :pings, :read_at
  end
end
