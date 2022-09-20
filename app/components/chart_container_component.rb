# frozen_string_literal: true

class ChartContainerComponent < ViewComponent::Base
  include ApplicationHelper
  renders_one :title
  renders_many :charts, 'BarChartComponent'
end
