# frozen_string_literal: true

class PageComponent < ViewComponent::Base
  def initialize(title:, subtitle: nil)
    @title = title
    @subtitle = subtitle
  end

end
