class LinkData < ApplicationRecord
  def self.new_link_data(link_data_type)
	case link_data_type
    when 'telephone'
      TelephoneLink.new
	when 'url'
	  UrlLink.new
	end
  end
end

require 'telephone_link.rb'
require 'url_link.rb'
