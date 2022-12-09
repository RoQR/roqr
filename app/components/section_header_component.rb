# frozen_string_literal: true

class SectionHeaderComponent < ApplicationComponent
  renders_one :title, lambda { |**options|
    options[:tag] ||= :h3
    options[:classes] = class_names(
      "text-lg leading-6 font-medium text-gray-800 dark:text-gray-100",
      options[:classes]
    )
    ApplicationComponent.new(**options)
  }
  renders_many :buttons, ButtonComponent

  def initialize(**options)
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      "pb-5 mb-3 border-b border-gray-300 dark:border-gray-700 flex items-center justify-between",
      options[:classes]
    )
  end

  def render?
    title.present?
  end
end
