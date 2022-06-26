# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  # https://petr.codes/blog/rails/modern-rails-flash-messages/part-1/
  include IconsHelper
  def initialize(type:, data:)
    @type = type
    @data = prepare_data(data)
    @icon = icon
    @icon_color = icon_color

    @data[:timeout] ||= 3
  end

  def icon
    case @type
    when 'success'
      show_svg('solid/check-circle')
    when 'info', 'notice'
      show_svg('solid/information-circle')
    when 'warn', 'alert'
      show_svg('solid/exclamation')
    when 'error'
      show_svg('solid/x-circle')
    end
  end

  def icon_color
    case @type
    when 'success'
      'text-green-400'
    when 'info', 'notice'
      'text-blue-400'
    when 'warn', 'alert'
      'text-red-400'
    when 'error'
      'text-red-800'
    end
  end

  private

  def prepare_data(data)
    case data
    when Hash
      # Rails seems to convert the keys to strings here. We need them as symbols, so we remap
      data.transform_keys(&:to_sym)
    else
      { title: data }
    end
  end
end
