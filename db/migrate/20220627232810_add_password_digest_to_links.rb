class AddPasswordDigestToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :password_digest, :string
  end
end
