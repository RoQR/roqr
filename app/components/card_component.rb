# frozen_string_literal: true

class CardComponent < ApplicationComponent
  def initialize(**options)
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      'bg-gray-200 dark:bg-gray-700 px-4 py-5 rounded-lg sm:p-6',
      options[:classes]
    )
  end
end
