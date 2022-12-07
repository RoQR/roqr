# frozen_string_literal: true

module Marketing
  class UrlLink
    include ActiveModel::API
    include ActiveModel::Serialization
    attr_accessor :url

    def type
      :url_link
    end

    def attributes
      { "type" => :url, "url" => nil }
    end

    def save
      true
    end

    def barcode_data
      url
    end
  end
end
