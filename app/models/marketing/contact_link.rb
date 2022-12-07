# frozen_string_literal: true

module Marketing
  class ContactLink
    include ActiveModel::API
    include ActiveModel::Serialization
    attr_accessor :first_name, :last_name, :phone, :email, :website, :company, :title, :address, :birthday, :note

    def type
      :contact_link
    end

    def attributes
      { "type" => :contact, "first_name" => nil, "last_name" => nil, "phone" => nil, "email" => nil, "website" => nil,
        "company" => nil, "title" => nil, "address" => nil, "birthday" => nil, "note" => nil }
    end

    def save
      true
    end

    def barcode_data
      vcard = VCardigan.create
      vcard.name last_name, first_name
      vcard.fullname "#{first_name} #{last_name}"
      vcard.bday birthday
      vcard.org company
      vcard.title title
      vcard.tel phone
      vcard.email email
      vcard.url website
      vcard.address address
      vcard.note note
      vcard.to_s
    end
  end
end
