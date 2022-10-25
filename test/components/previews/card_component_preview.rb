# frozen_string_literal: true

class CardComponentPreview < ViewComponent::Preview
  def default
    render(CardComponent.new.with_content('Card'))
  end
end
