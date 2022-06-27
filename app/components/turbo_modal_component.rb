# frozen_string_literal: true

class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include IconsHelper
  def initialize(title:, resource:)
    @title = title
    @resource = resource
  end
end
