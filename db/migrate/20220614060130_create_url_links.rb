class CreateUrlLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :url_links, id: :uuid do |t|
      t.text :url

      t.timestamps
    end
  end
end
