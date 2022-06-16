class CreateSmsLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :sms_links, id: :uuid do |t|
      t.text :number
      t.text :body

      t.timestamps
    end
  end
end
