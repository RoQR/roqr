# frozen_string_literal: true
class FeatureCardComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(title:, icon:)
    @title = title
    @icon = icon
  end
end
