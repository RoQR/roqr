# frozen_string_literal: true

module ScansHelper
  def filtered?
    [@link_filter, @platform_filter, @browser_filter, @country_filter].any?(&:present?)
  end

  def chart_data(group_variable)
    @scans.group(group_variable).order("count_id desc").count("id")
  end
end
