# frozen_string_literal: true

class NavbarComponentPreview < ViewComponent::Preview
  def standard
    render(NavbarComponent.new)
  end
end
