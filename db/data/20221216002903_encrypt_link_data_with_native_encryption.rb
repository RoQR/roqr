# frozen_string_literal: true

class EncryptLinkDataWithNativeEncryption < ActiveRecord::Migration[7.0]
  def up
    ContactLink.all.each do |l|
      l.encrypt
    end
    EmailLink.all.each do |l|
      l.encrypt
    end
    SmsLink.all.each do |l|
      l.encrypt
    end
    UrlLink.all.each do |l|
      l.encrypt
    end
    TelephoneLink.all.each do |l|
      l.encrypt
    end
    WifiLink.all.each do |l|
      l.encrypt
    end
  end

  def down
  end
end
