class CreateContactLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_links, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :website
      t.string :company
      t.string :title
      t.string :address
      t.date :birthday
      t.string :note

      t.timestamps
    end
  end
end
