# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
  end
end
