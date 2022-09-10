# frozen_string_literal: true

class TurboModalComponent < ApplicationComponent
  include Turbo::FramesHelper
  include IconsHelper
  def initialize(title:)
    @title = title
  end
end
