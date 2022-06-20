class LinkData < ApplicationRecord
  def self.new_link_data(link_data_type)
	case link_data_type
	when 'url'
	  UrlLink.new
	end
  end
end

require 'url_link.rb'
