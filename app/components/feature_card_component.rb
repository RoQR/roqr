# frozen_string_literal: true

class FeatureCardComponent < ApplicationComponent
  include IconsHelper
  def initialize(title:, icon:)
    @title = title
    @icon = icon
  end
end
