class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.boolean :can_create_links

      t.timestamps
    end
  end
end
