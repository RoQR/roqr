# frozen_string_literal: true

class SectionHeaderComponentPreview < ViewComponent::Preview
  def default
    render SectionHeaderComponent.new do |c|
      c.with_title do
        'Title'
      end
    end
  end

  def with_button
    render SectionHeaderComponent.new do |c|
      c.with_title do
        'Title'
      end
      c.with_button do
        'Button'
      end
    end
  end
end
