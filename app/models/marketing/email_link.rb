# frozen_string_literal: true

module Marketing
  class EmailLink
    include ActiveModel::API
    include ActiveModel::Serialization
    include ERB::Util
    attr_accessor :email_address, :subject, :body

    def type
      :email_link
    end

    def attributes
      { "type" => :email, "email_address" => nil, "subject" => nil, "body" => nil }
    end

    def save
      true
    end

    def barcode_data
      "mailto:#{u email_address}?subject=#{u subject}&body=#{u body}"
    end
  end
end
