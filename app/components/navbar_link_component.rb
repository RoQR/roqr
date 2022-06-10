# frozen_string_literal: true

class NavbarLinkComponent < ViewComponent::Base
  def initialize(title:, link:, is_active: false, is_mobile: false)
    @title = title
    @link = link
    @is_active = is_active
    @is_mobile = is_mobile
  end
end
