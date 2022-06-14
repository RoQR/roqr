class MakeLinksPolymorphic < ActiveRecord::Migration[7.0]
  def change
    drop_table :links, force: :cascade
    create_table :links, id: :uuid do |t|
      t.text :name, null: false
      t.references :link_data, type: :uuid, polymorphic: true, null: true
      t.references :user, type: :uuid

      t.timestamps
    end
  end
end
