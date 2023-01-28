# frozen_string_literal: true

class ToggleComponent < ViewComponent::Base
  include ComponentHelper

  def initialize(name, form: nil, **options)
    @name = name
    @form = form
    @options = options
    @data = options[:data]
    @classes = class_names(
      "inline-flex relative items-center cursor-pointer",
      options[:classes]
    )
  end
end
