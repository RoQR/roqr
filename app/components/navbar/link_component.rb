# frozen_string_literal: true

class Navbar::LinkComponent < ApplicationComponent
  def initialize(title:, link:, is_active: false, is_mobile: false)
    @title = title
    @link = link
    @is_active = is_active
    @is_mobile = is_mobile
  end

  def html_class
    (@is_active ? 'text-gray-50' : 'text-gray-600 dark:text-gray-300 hover:text-gray-50') +
      (@is_mobile ? ' text-base block' : ' text-sm') +
      ' px-3 py-2 rounded-md font-medium'
  end
end
