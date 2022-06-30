class CreateTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :templates, id: :uuid do |t|
      t.string :name, null: false
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :color, null: false, default: '#000000'
      t.string :fill, null: false, default: '#ffffff'

      t.timestamps
    end
  end
end
