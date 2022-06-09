class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid do |t|
      t.belongs_to :link, type: :uuid, foreign_key: true
      t.string :browser_name
      t.string :browser_version
      t.string :bot_name
      t.string :device_name
      t.string :platform_name
      t.string :platform_version
      t.string :language

      t.timestamps
    end
  end
end
