class DropLockboxEncryptedColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :contact_links, :first_name_ciphertext
    remove_column :contact_links, :last_name_ciphertext
    remove_column :contact_links, :phone_ciphertext
    remove_column :contact_links, :email_ciphertext
    remove_column :contact_links, :website_ciphertext
    remove_column :contact_links, :company_ciphertext
    remove_column :contact_links, :title_ciphertext
    remove_column :contact_links, :address_ciphertext
    remove_column :contact_links, :birthday_ciphertext
    remove_column :contact_links, :note_ciphertext
    remove_column :email_links, :email_address_ciphertext
    remove_column :email_links, :subject_ciphertext
    remove_column :email_links, :body_ciphertext
    remove_column :sms_links, :number_ciphertext
    remove_column :sms_links, :body_ciphertext
    remove_column :telephone_links, :number_ciphertext
    remove_column :url_links, :url_ciphertext
    remove_column :wifi_links, :ssid_ciphertext
    remove_column :wifi_links, :password_ciphertext
    remove_column :wifi_links, :hidden_ciphertext
    remove_column :wifi_links, :protocol_ciphertext
  end
end
