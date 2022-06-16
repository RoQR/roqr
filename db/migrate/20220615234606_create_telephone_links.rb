class CreateTelephoneLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :telephone_links, id: :uuid do |t|
      t.string :number

      t.timestamps
    end
  end
end
