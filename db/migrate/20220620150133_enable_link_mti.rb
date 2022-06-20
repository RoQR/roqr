class EnableLinkMti < ActiveRecord::Migration[7.0]
  def change
    remove_column :links, :link_data_id 
    remove_column :links, :link_data_type 
    add_reference :links, :contact_link, type: :uuid
    add_reference :links, :email_link, type: :uuid
    add_reference :links, :sms_link, type: :uuid
    add_reference :links, :telephone_link, type: :uuid
    add_reference :links, :url_link, type: :uuid
    add_reference :links, :wifi_link, type: :uuid
  end
end