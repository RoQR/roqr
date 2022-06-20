class AddXorConstraintToLinksType < ActiveRecord::Migration[7.0]
  def self.up
    execute "ALTER TABLE links ADD CONSTRAINT link_data_xor check(
    (contact_link_id   is not null)::integer +
    (email_link_id     is not null)::integer +
    (sms_link_id       is not null)::integer +
    (telephone_link_id is not null)::integer +
    (url_link_id       is not null)::integer +
    (wifi_link_id      is not null)::integer = 1
    );"
  end

  def self.down
    execute "ALTER TABLE links DROP CONSTRAINT link_data_xor"
  end
end
