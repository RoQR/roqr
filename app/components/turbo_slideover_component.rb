# frozen_string_literal: true

class TurboSlideoverComponent < ApplicationComponent
  include Turbo::FramesHelper
  def initialize(title:)
    @title = title
  end
end
