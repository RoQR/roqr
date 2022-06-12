# frozen_string_literal: true

class InlineButtonGroupComponent < ViewComponent::Base
  renders_many :buttons, ButtonComponent
end
