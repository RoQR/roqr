class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.text :users, :private_api_key_ciphertext
      
      # blind index
      t.string :private_api_key_bidx
      t.index :private_api_key_bidx, unique: true

      t.timestamps
    end
  end
end
