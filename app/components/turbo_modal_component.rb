# frozen_string_literal: true

class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include IconsHelper
  def initialize(title:)
    @title = title
  end
end
