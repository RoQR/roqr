class AddIdColumns < ActiveRecord::Migration[7.0]
  def change
    # New ids
    add_column :contact_links, :new_id, :serial
    add_column :email_links, :new_id, :serial
    add_column :links, :new_id, :serial
    add_column :notifications, :new_id, :serial
    add_column :organizations, :new_id, :serial
    add_column :public_pages, :new_id, :serial
    add_column :requests, :new_id, :serial
    add_column :scans, :new_id, :serial
    add_column :sms_links, :new_id, :serial
    add_column :styles, :new_id, :serial
    add_column :subscriptions, :new_id, :serial
    add_column :telephone_links, :new_id, :serial
    add_column :url_links, :new_id, :serial
    add_column :users, :new_id, :serial
    add_column :wifi_links, :new_id, :serial
    # New association ids
    add_column :links, :user_new_id, :bigint
    add_column :links, :contact_link_new_id, :bigint
    add_column :links, :email_link_new_id, :bigint
    add_column :links, :sms_link_new_id, :bigint
    add_column :links, :telephone_link_new_id, :bigint
    add_column :links, :url_link_new_id, :bigint
    add_column :links, :wifi_link_new_id, :bigint
    add_column :links, :organization_new_id, :bigint
    add_column :links_public_pages, :link_new_id, :bigint
    add_column :links_public_pages, :public_page_new_id, :bigint
    add_column :notifications, :recipient_new_id, :bigint
    add_column :public_pages, :organization_new_id, :bigint
    add_column :requests, :user_new_id, :bigint
    add_column :scans, :link_new_id, :bigint
    add_column :styles, :organization_new_id, :bigint
    add_column :subscriptions, :organization_new_id, :bigint
    add_column :users, :organization_new_id, :bigint
    add_column :users, :invited_by_new_id, :bigint
  end
end
