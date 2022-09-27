# frozen_string_literal: true

module ApplicationHelper
  def truthy?(arg)
    ActiveModel::Type::Boolean.new.cast(arg)
  end

  def render_component(component_path, collection: nil, **options, &block)
    component_klass = "#{component_path.classify}Component".constantize

    if collection
      render component_klass.with_collection(collection, **options), &block
    else
      render component_klass.new(**options), &block
    end
  end
end
