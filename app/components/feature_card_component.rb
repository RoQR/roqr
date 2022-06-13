# frozen_string_literal: true
class FeatureCardComponent < ViewComponent::Base
  include IconsHelper
  def initialize(title:, icon:)
    @title = title
    @icon = icon
  end
end
