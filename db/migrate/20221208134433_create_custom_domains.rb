class CreateCustomDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_domains do |t|
      t.string :url
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
