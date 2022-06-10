class NavbarLinkComponentPreview < ViewComponent::Preview
  def standard
    render(NavbarLinkComponent.new(title: 'Title', link: '#'))
  end
  def active
    render(NavbarLinkComponent.new(title: 'Title', link: '#', is_active: true))
  end
  def mobile
    render(NavbarLinkComponent.new(title: 'Title', link: '#', is_mobile: true))
  end
  def active_mobile
    render(NavbarLinkComponent.new(title: 'Title', link: '#', is_active: true, is_mobile: true))
  end
end
