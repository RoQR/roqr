# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  # @group sizes
  def xs
    render(ButtonComponent.new(size: :xs).with_content('Button'))
  end

  def sm
    render(ButtonComponent.new(size: :sm).with_content('Button'))
  end

  def md
    render(ButtonComponent.new(size: :md).with_content('Button'))
  end

  def lg
    render(ButtonComponent.new(size: :lg).with_content('Button'))
  end

  def xl
    render(ButtonComponent.new(size: :xl).with_content('Button'))
  end
  # !@endgroup

  # @group styles
  def primary
    render(ButtonComponent.new(style: :primary).with_content('Button'))
  end

  def secondary
    render(ButtonComponent.new(style: :secondary).with_content('Button'))
  end

  def destructive
    render(ButtonComponent.new(style: :destructive).with_content('Button'))
  end
  # !@endgroup
end
