# frozen_string_literal: true

class MigrateCiphertextColumns < ActiveRecord::Migration[7.0]
  def up
    Lockbox.migrate(ContactLink)
    Lockbox.migrate(EmailLink)
    Lockbox.migrate(SmsLink)
    Lockbox.migrate(UrlLink)
    Lockbox.migrate(TelephoneLink)
    Lockbox.migrate(WifiLink)
  end

  def down
  end
end
