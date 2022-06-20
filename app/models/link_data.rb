class LinkData < ApplicationRecord
  def self.new_link_data(link_data_type)
	case link_data_type
    when 'contact'
      ContactLink.new
    when 'email'
      EmailLink.new
    when 'sms'
      SmsLink.nw
    when 'telephone'
      TelephoneLink.new
	when 'url'
	  UrlLink.new
    when 'wifi'
      WifiLink.new
	end
  end
end

require 'contact_link.rb'
require 'email_link.rb'
require 'sms_link.rb'
require 'telephone_link.rb'
require 'url_link.rb'
require 'wifi_link.rb'
