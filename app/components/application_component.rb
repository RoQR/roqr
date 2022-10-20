# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include ComponentHelper

  def initialize(tag: nil, classes: nil, **options)
    @tag = tag
    @classes = classes
    @options = options
  end

  def call
    content_tag(@tag, content, class: @classes, **@options) if @tag
  end

  def merge_attributes(*args)
    args = Array.new(2) { {} } if args.compact.blank?
    hashed_args = args.map { |el| el.presence || {} }

    hashed_args.first.deep_merge(hashed_args.second) do |_key, val, other_val|
      val + " #{other_val}"
    end
  end
end
