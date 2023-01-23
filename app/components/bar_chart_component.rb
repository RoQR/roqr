# frozen_string_literal: true

class BarChartComponent < ViewComponent::Base
  def initialize(label_unit:, data_unit:, data:, filter: true)
    @label_unit = label_unit
    @data_unit = data_unit
    @data = data
    @max_count = data.map { |_, v| v }.max
    @filter = filter
  end

  def title
    @label_unit
  end
end
