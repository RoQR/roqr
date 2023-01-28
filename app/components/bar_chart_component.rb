# frozen_string_literal: true

class BarChartComponent < ViewComponent::Base
  def initialize(label_unit:, data_unit:, data:)
    @label_unit = label_unit
    @data_unit = data_unit
    @data = data
    @max_count = data.values.max
    @expandable = @data.count > 5
  end

  def title
    @label_unit
  end

  private

  def row(title, count)
    content_tag(:div, class: "flex items-center justify-between my-1 text-sm") do
      content_tag(:div, class: "w-full relative", style: "max-width: calc(100% - 5rem);") do
        content_tag(:div, nil, class: "absolute top-0 left-0 h-full bg-gray-200 dark:bg-gray-600",
                               style: "width: #{100.0 * count / @max_count}%;") +
          (content_tag(:span, class: "flex px-2 py-1.5 group relative z-9 break-all") do
            if title.present?
              link_to request.params.merge("#{@label_unit.downcase}_filter": title),
                      class: "hover:underline decoration-gray-800 dark:decoration-gray-100", data: { turbo_action: "advance", turbo_frame: "scans" } do
                content_tag(:p, class: "md:truncate block text-gray-800 dark:text-gray-100") do
                  title || "Unknown"
                end
              end
            else
              content_tag(:p, class: "md:truncate block text-gray-800 dark:text-gray-100") do
                title || "Unknown"
              end
            end
          end)
      end +
        content_tag(:span, count, class: "w-20 text-right text-gray-800 dark:text-gray-100", tooltip: count)
    end
  end
end
