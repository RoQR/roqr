# frozen_string_literal: true

class ContactLink < LinkData
  self.table_name = "contact_links"
  has_one :link
  has_encrypted :first_name, :last_name, :phone, :email, :website, :company, :title, :address, :note
  has_encrypted :birthday, type: :date
  self.ignored_columns = %w[first_name last_name phone email website company title address
                            note birthday]
  include ERB::Util

  def summary
    [first_name, last_name].compact.join(" ")
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
