# frozen_string_literal: true

module ApplicationHelper
  def truthy?(arg)
    ActiveModel::Type::Boolean.new.cast(arg) || false
  end

  def render_component(component_path, collection: nil, **options, &block)
    component_klass = "#{component_path.to_s.classify}Component".constantize

    if collection
      render component_klass.with_collection(collection, **options), &block
    else
      render component_klass.new(**options), &block
    end
  end
end
