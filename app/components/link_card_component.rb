# frozen_string_literal: true

class LinkCardComponent < ViewComponent::Base
  include LinksHelper

  def initialize(link:, can_edit: false, can_delete: false)
    @link = link
    @can_edit = can_edit
    @can_delete = can_delete
  end

  def name
    @link.name
  end

  def type
    if @link.link_data.is_a?(UrlLink)
      'url'
    elsif @link.link_data.is_a?(EmailLink)
      'email'
    end
  end

  def badge_color
    case type
    when 'url'
      'text-green-800 bg-green-100'
    when 'email'
      'text-blue-800 bg-blue-100'
    end
  end

  def badge_text
    case type
    when'url'
      'Url'
    when 'email'
      'Email'
    end
  end

  def num_events
    @link.events.count
  end

  def qr_image
    image = qr(link_url(@link)).as_png(size: 480)
    image.to_s
  end
end
