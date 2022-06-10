# frozen_string_literal: true

class SectionHeaderComponent < ViewComponent::Base
  renders_one :title
  renders_one :button, ButtonComponent
end
