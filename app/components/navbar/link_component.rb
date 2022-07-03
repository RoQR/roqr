# frozen_string_literal: true

class Navbar::LinkComponent < ViewComponent::Base
  def initialize(title:, link:, is_active: false, is_mobile: false)
    @title = title
    @link = link
    @is_active = is_active
    @is_mobile = is_mobile
  end

  def html_class
    (@is_active ? 'bg-slate-900 text-white' : 'text-slate-300 hover:bg-slate-700 hover:text-white') +
      (@is_mobile ? ' text-base block' : ' text-sm') +
      ' px-3 py-2 rounded-md font-medium'
  end
end
