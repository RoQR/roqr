# frozen_string_literal: true

class LinkData < ApplicationRecord
  TYPES = %i[contact_link email_link sms_link telephone_link url_link wifi_link].freeze
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

  def self.static_only?
    false
  end
end

require 'contact_link'
require 'email_link'
require 'sms_link'
require 'telephone_link'
require 'url_link'
require 'wifi_link'
