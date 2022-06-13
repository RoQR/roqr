# frozen_string_literal: true
class FeatureCardComponent < ViewComponent::Base
  include IconHelper
  def initialize(title:, icon:)
    @title = title
    @icon = icon
  end
end
