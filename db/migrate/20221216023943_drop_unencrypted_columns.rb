class DropUnencryptedColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :contact_links, :first_name
    remove_column :contact_links, :last_name
    remove_column :contact_links, :phone
    remove_column :contact_links, :email
    remove_column :contact_links, :website
    remove_column :contact_links, :company
    remove_column :contact_links, :title
    remove_column :contact_links, :address
    remove_column :contact_links, :birthday
    remove_column :contact_links, :note
    remove_column :email_links, :email_address
    remove_column :email_links, :subject
    remove_column :email_links, :body
    remove_column :sms_links, :number
    remove_column :sms_links, :body
    remove_column :telephone_links, :number
    remove_column :url_links, :url
    remove_column :wifi_links, :ssid
    remove_column :wifi_links, :password
    remove_column :wifi_links, :hidden
    remove_column :wifi_links, :protocol
  end
end
