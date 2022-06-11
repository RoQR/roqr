# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(link:, method: :get, size: 'md', style: 'primary')
    @link = link
    @size = size
    @method = method
    @style = style
  end

  def px
    case @size
    when 'xs'
      'px-2.5'
    when 'sm'
      'px-3'
    when 'md'
      'px-4'
    when 'lg'
      'px-4'
    when 'xl'
      'px-6'
    end
  end

  def py
    case @size
    when 'xs'
      'py-1.5'
    when 'sm'
      'py-2'
    when 'md'
      'py-2'
    when 'lg'
      'py-2'
    when 'xl'
      'py-3'
    end
  end

  def text_size
    case @size
    when 'xs'
      'text-xs'
    when 'sm'
      'text-sm'
    when 'md'
      'text-sm'
    when 'lg'
      'text-base'
    when 'xl'
      'text-base'
    end
  end

  def styling
    case @style
    when 'primary'
      'border-transparent text-white bg-indigo-600 hover:bg-indigo-700 '
    when 'white'
      'border-gray-300 text-gray-700 bg-white hover:bg-gray-50'
    end
  end
end
