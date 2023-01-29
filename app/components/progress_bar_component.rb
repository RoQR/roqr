# frozen_string_literal: true

class ProgressBarComponent < ApplicationComponent
  def initialize(width, **options)
    @width = width * 100.0
    @options = options
    @options[:tag] ||= :div
    @options[:classes] = class_names(
      "overflow-hidden rounded-full bg-gray-200",
      @options[:classes]
    )
  end
end
