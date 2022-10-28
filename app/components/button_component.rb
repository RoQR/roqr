# frozen_string_literal: true

class ButtonComponent < ApplicationComponent
  STYLE_DEFAULT = :primary
  STYLE_MAPPINGS = {
    STYLE_DEFAULT => 'border-transparent text-gray-900 bg-yellow-400 hover:bg-yellow-500 focus:ring-yellow-500',
    :secondary => 'border-gray-400 dark:border-gray-500 text-gray-500 dark:text-gray-400 bg-transparent hover:bg-transparent/5',
    :destructive => 'border-transparent text-gray-50 bg-red-600 hover:bg-red-700 focus:ring-red-500'
  }
  STYLE_OPTIONS = STYLE_MAPPINGS.keys

  SIZE_DEFAULT = :md
  SIZE_MAPPINGS = {
    :xs => 'px-2.5 py-1.5 text-xs',
    :sm => 'px-3 py-2 text-sm',
    SIZE_DEFAULT => 'px-4 py-2 text-sm',
    :lg => 'px-4 py-2 text-base',
    :xl => 'px-6 py-3 text-base'
  }
  SIZE_OPTIONS = SIZE_MAPPINGS.keys

  def initialize(href: nil, method: nil, size: :md, style: :primary, **options)
    @options = options
    @options[:tag] ||= href.nil? || (method.presence != :get) ? :button : :a
    @options[:href] = href
    @options[:method] = method unless method.nil?
    @options[:classes] = class_names(
      'inline-flex items-center border font-medium rounded shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2',
      STYLE_MAPPINGS[fetch_or_fallback(STYLE_OPTIONS, style, STYLE_DEFAULT)],
      SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)],
      options[:classes]
    )
  end
end
