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

  def num_events
    @link.events.count
  end

  def qr_image
    image = qr(link_url(@link)).as_png(size: 480)
    image.to_s
  end
end
