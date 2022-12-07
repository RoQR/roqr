# frozen_string_literal: true

module Marketing
  class TelephoneLink
    include ActiveModel::API
    include ActiveModel::Serialization
    include ERB::Util
    attr_accessor :number

    def type
      :telephone_link
    end

    def attributes
      { "type" => :telephone, "number" => nil }
    end

    def save
      true
    end

    def barcode_data
      "tel:#{u number}"
    end
  end
end
