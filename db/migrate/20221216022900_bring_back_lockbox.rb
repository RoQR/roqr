class BringBackLockbox < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_links, :first_name_ciphertext, :text
    add_column :contact_links, :last_name_ciphertext, :text
    add_column :contact_links, :phone_ciphertext, :text
    add_column :contact_links, :email_ciphertext, :text
    add_column :contact_links, :website_ciphertext, :text
    add_column :contact_links, :company_ciphertext, :text
    add_column :contact_links, :title_ciphertext, :text
    add_column :contact_links, :address_ciphertext, :text
    add_column :contact_links, :birthday_ciphertext, :text
    add_column :contact_links, :note_ciphertext, :text
    add_column :email_links, :email_address_ciphertext, :text
    add_column :email_links, :subject_ciphertext, :text
    add_column :email_links, :body_ciphertext, :text
    add_column :sms_links, :number_ciphertext, :text
    add_column :sms_links, :body_ciphertext, :text
    add_column :telephone_links, :number_ciphertext, :text
    add_column :url_links, :url_ciphertext, :text
    add_column :wifi_links, :ssid_ciphertext, :text
    add_column :wifi_links, :password_ciphertext, :text
    add_column :wifi_links, :hidden_ciphertext, :text
    add_column :wifi_links, :protocol_ciphertext, :text
  end
end
