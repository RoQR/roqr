class AddAcceptedTermsOfServiceToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :terms_accepted, :boolean, nil: false, default: false
  end
end
