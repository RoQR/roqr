# frozen_string_literal: true

module LinksHelper
  def barcode_data(link)
    if link.dynamic?
      if link.custom_domain
        link.custom_domain.url + scan_link_path(id: link.hashid)
      else
        scan_link_url(id: link.hashid)
      end

    else
      link.barcode_data
    end
  end

  def type(link)
    case link.link_data
    when UrlLink
      "URL"
    when EmailLink
      "Email"
    when WifiLink
      "WiFi"
    when TelephoneLink
      "Telephone"
    when SmsLink
      "SMS"
    when ContactLink
      "Contact"
    end
  end
end
