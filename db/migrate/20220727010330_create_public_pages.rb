class CreatePublicPages < ActiveRecord::Migration[7.0]
  def change
    create_table :public_pages, id: :uuid do |t|
      t.string :name, null: false
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
