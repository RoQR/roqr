class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links, id: :uuid do |t|
      t.text :url
      t.text :name

      t.timestamps
    end
  end
end
