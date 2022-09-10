# frozen_string_literal: true

class InlineButtonGroupComponent < ApplicationComponent
  renders_many :buttons, ButtonComponent
end
