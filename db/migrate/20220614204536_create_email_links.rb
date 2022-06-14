class CreateEmailLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :email_links, id: :uuid do |t|
      t.text :email_address
      t.text :subject
      t.text :body

      t.timestamps
    end
  end
end
