class MoveToNewIds < ActiveRecord::Migration[7.0]
  def up
    # Make association ids not null
    change_column_null :links, :organization_new_id, false
    change_column_null :links_public_pages, :link_new_id, false
    change_column_null :links_public_pages, :public_page_new_id, false
    change_column_null :notifications, :recipient_new_id, false
    change_column_null :public_pages, :organization_new_id, false
    change_column_null :requests, :user_new_id, false
    change_column_null :scans, :link_new_id, false
    change_column_null :styles, :organization_new_id, false
    change_column_null :subscriptions, :organization_new_id, false
    change_column_null :users, :organization_new_id, false
    # Drop constraint
    execute 'ALTER TABLE links DROP CONSTRAINT link_data_xor'
    # Delete old ids
    remove_column :links, :user_id # this one can be dropped completely, it's unused
    remove_column :links, :user_new_id # this one can be dropped completely, it's unused
    remove_column :links, :contact_link_id
    remove_column :links, :email_link_id
    remove_column :links, :sms_link_id
    remove_column :links, :telephone_link_id
    remove_column :links, :url_link_id
    remove_column :links, :wifi_link_id
    remove_column :links, :organization_id
    remove_column :links_public_pages, :link_id
    remove_column :links_public_pages, :public_page_id
    remove_column :notifications, :recipient_id
    remove_column :public_pages, :organization_id
    remove_column :requests, :user_id
    remove_column :scans, :link_id
    remove_column :styles, :organization_id
    remove_column :subscriptions, :organization_id
    remove_column :users, :organization_id
    remove_column :users, :invited_by_id
    # Move to new ids
    rename_column :links, :contact_link_new_id, :contact_link_id
    rename_column :links, :sms_link_new_id, :sms_link_id
    rename_column :links, :email_link_new_id, :email_link_id
    rename_column :links, :telephone_link_new_id, :telephone_link_id
    rename_column :links, :url_link_new_id, :url_link_id
    rename_column :links, :wifi_link_new_id, :wifi_link_id
    rename_column :links, :organization_new_id, :organization_id
    rename_column :links_public_pages, :link_new_id, :link_id
    rename_column :links_public_pages, :public_page_new_id, :public_page_id
    rename_column :notifications, :recipient_new_id, :recipient_id
    rename_column :public_pages, :organization_new_id, :organization_id
    rename_column :requests, :user_new_id, :user_id
    rename_column :scans, :link_new_id, :link_id
    rename_column :styles, :organization_new_id, :organization_id
    rename_column :subscriptions, :organization_new_id, :organization_id
    rename_column :users, :organization_new_id, :organization_id
    rename_column :users, :invited_by_new_id, :invited_by_id
    # Add indexes for associations
    add_index :links, :contact_link_id
    add_index :links, :email_link_id
    add_index :links, :sms_link_id
    add_index :links, :telephone_link_id
    add_index :links, :url_link_id
    add_index :links, :wifi_link_id
    add_index :links, :organization_id
    add_index :links_public_pages, :link_id
    add_index :links_public_pages, :public_page_id
    add_index :notifications, :recipient_id
    add_index :public_pages, :organization_id
    add_index :requests, :user_id
    add_index :scans, :link_id
    add_index :styles, :organization_id
    add_index :subscriptions, :organization_id
    add_index :users, :organization_id
    add_index :users, :invited_by_id
    # Migrate primary keys
    remove_column :contact_links, :id
    remove_column :email_links, :id
    remove_column :links, :id
    remove_column :notifications, :id
    remove_column :organizations, :id
    remove_column :public_pages, :id
    remove_column :requests, :id
    remove_column :scans, :id
    remove_column :sms_links, :id
    remove_column :styles, :id
    remove_column :subscriptions, :id
    remove_column :telephone_links, :id
    remove_column :url_links, :id
    remove_column :users, :id
    remove_column :wifi_links, :id
    rename_column :contact_links, :new_id, :id
    rename_column :email_links, :new_id, :id
    rename_column :links, :new_id, :id
    rename_column :notifications, :new_id, :id
    rename_column :organizations, :new_id, :id
    rename_column :public_pages, :new_id, :id
    rename_column :requests, :new_id, :id
    rename_column :scans, :new_id, :id
    rename_column :sms_links, :new_id, :id
    rename_column :styles, :new_id, :id
    rename_column :subscriptions, :new_id, :id
    rename_column :telephone_links, :new_id, :id
    rename_column :url_links, :new_id, :id
    rename_column :users, :new_id, :id
    rename_column :wifi_links, :new_id, :id
    execute 'ALTER TABLE contact_links ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE email_links ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE links ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE notifications ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE organizations ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE public_pages ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE requests ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE scans ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE sms_links ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE styles ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE subscriptions ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE telephone_links ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE url_links ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE users ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE wifi_links ADD PRIMARY KEY (id);'
    # Add foreign keys
    add_foreign_key :links, :contact_links
    add_foreign_key :links, :email_links
    add_foreign_key :links, :sms_links
    add_foreign_key :links, :telephone_links
    add_foreign_key :links, :url_links
    add_foreign_key :links, :wifi_links
    add_foreign_key :links, :organizations
    add_foreign_key :links_public_pages, :links
    add_foreign_key :links_public_pages, :public_pages
    add_foreign_key :public_pages, :organizations
    add_foreign_key :requests, :users
    add_foreign_key :scans, :links
    add_foreign_key :styles, :organizations
    add_foreign_key :subscriptions, :organizations
    add_foreign_key :users, :organizations
    # Re-add constraint
    execute "ALTER TABLE links ADD CONSTRAINT link_data_xor_new check(
      (contact_link_id   is not null)::integer +
      (email_link_id     is not null)::integer +
      (sms_link_id       is not null)::integer +
      (telephone_link_id is not null)::integer +
      (url_link_id       is not null)::integer +
      (wifi_link_id      is not null)::integer = 1
    );"
    # Add indexes for sorting
    add_index :contact_links, :created_at
    add_index :email_links, :created_at
    add_index :links, :created_at
    add_index :notifications, :created_at
    add_index :organizations, :created_at
    add_index :public_pages, :created_at
    add_index :requests, :created_at
    add_index :scans, :created_at
    add_index :sms_links, :created_at
    add_index :styles, :created_at
    add_index :subscriptions, :created_at
    add_index :telephone_links, :created_at
    add_index :url_links, :created_at
    add_index :users, :created_at
    add_index :wifi_links, :created_at
  end

  def self.down; end
end
