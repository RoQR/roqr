# frozen_string_literal: true

class FilterComponent < ApplicationComponent
  def initialize(field, value, **options)
    @field = field
    @value = value
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      "flex flex-row bg-gray-300 text-gray-600 dark:bg-gray-700 dark:text-gray-300 px-3 py-1.5 rounded-full",
      options[:classes]
    )
  end

  def text
    sanitize "<span>#{@field}: <b>#{@value}</b></span>"
  end

  def render?
    @value.present?
  end
end
