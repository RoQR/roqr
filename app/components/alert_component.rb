# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  include IconHelper
  def initialize(status:)
    @status = status
  end

  private

  def bg_color
    case @status
    when 'success'
      'bg-green-50'
    when 'info', 'notice'
      'bg-blue-50'
    when 'warn', 'alert'
      'bg-yellow-50'
    when 'error'
      'bg-red-50'
    end
  end

  def text_color
    case @status
    when 'success'
      'text-green-700'
    when 'info', 'notice'
      'text-blue-700'
    when 'warn', 'alert'
      'text-yellow-700'
    when 'error'
      'text-red-700'
    end
  end

  def icon
    case @status
    when 'success'
      show_svg('solid-check-circle')
    when 'info', 'notice'
      show_svg('solid-information-circle')
    when 'warn', 'alert'
      show_svg('solid-exclamation')
    when 'error'
      show_svg('solid-x-circle')
    end
  end

  def x_button_colors
    case @status
    when 'success'
        "bg-green-50 text-green-500 hover:bg-green-100 focus:ring-offset-green-50 focus:ring-green-600"
    when 'info', 'notice'
        "bg-blue-50 text-blue-500 hover:bg-blue-100 focus:ring-offset-blue-50 focus:ring-blue-600"
    when 'warn', 'alert'
        "bg-yellow-50 text-yellow-500 hover:bg-yellow-100 focus:ring-offset-yellow-50 focus:ring-yellow-600"
    when 'error'
        "bg-red-50 text-red-500 hover:bg-red-100 focus:ring-offset-red-50 focus:ring-red-600"
    end
  end
end
