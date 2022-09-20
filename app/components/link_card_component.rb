# frozen_string_literal: true

class LinkCardComponent < ApplicationComponent
  include IconsHelper
  include LinksHelper

  def initialize(link:, **options)
    @link = link
    @options = options
  end

  def name
    @link.name
  end

  def type
    case @link.link_data
    when UrlLink
      'url'
    when EmailLink
      'email'
    when WifiLink
      'wifi'
    when TelephoneLink
      'telephone'
    when SmsLink
      'sms'
    when ContactLink
      'contact'
    end
  end

  def badge_color
    case type
    when 'url'
      'text-green-800 bg-green-100'
    when 'email'
      'text-blue-800 bg-blue-100'
    when 'wifi'
      'text-fuchsia-800 bg-fuchsia-100'
    when 'telephone'
      'text-amber-800 bg-amber-100'
    when 'sms'
      'text-gray-800 bg-gray-100'
    when 'contact'
      'text-rose-800 bg-rose-100'
    end
  end

  def badge_text
    case type
    when 'url'
      'Url'
    when 'email'
      'Email'
    when 'wifi'
      'WiFi'
    when 'telephone'
      'Telephone'
    when 'sms'
      'SMS'
    when 'contact'
      'Contact'
    end
  end

  def num_scans
    @link.scans.count
  end

  def qr_image
    image = qr(link_url(@link)).as_png(size: 480)
    image.to_s
  end
end
