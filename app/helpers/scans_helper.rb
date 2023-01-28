# frozen_string_literal: true

module ScansHelper
  def filtered?
    [@link, @platform, @browser, @country].any?(&:present?)
  end
end
