# frozen_string_literal: true

module BreadcrumbsHelper
  class RoqrBreadcrumbs < BreadcrumbsOnRails::Breadcrumbs::Builder
    include ApplicationHelper
    include ERB::Util

    def chevron_left
      @context.content_tag(:div, class: "text-gray-500") do
        File.binread("app/assets/icons/solid/chevron-left.svg").html_safe
      end
    end

    def chevron_right
      @context.content_tag(:div, class: "text-gray-500") do
        File.binread("app/assets/icons/solid/chevron-right.svg").html_safe
      end
    end

    def render
      @context.content_tag(:div, class: "mt-6 flex items-center space-x-1 sm:space-x-3") do
        if @elements.length == 1
          chevron_left + html_escape(render_element(@elements.first))
        else
          @elements.collect do |element|
            html_escape(render_element(element))
          end.join(chevron_right).html_safe
        end
      end
    end

    def render_element(element)
      content = build_content(element)
      if @options[:tag]
        @context.content_tag(@options[:tag], content)
      else
        ERB::Util.h(content)
      end
    end

    private

    def build_content(element)
      if element.path.nil?
        content_no_path(element)
      else
        content_with_path(element)
      end
    end

    def content_no_path(element)
      @context.content_tag(:p, class: "text-sm font-medium text-gray-500") do
        compute_name(element)
      end
    end

    def content_with_path(element)
      element.options[:class] = "text-sm font-medium text-gray-500 hover:text-gray-700"
      @context.link_to_unless_current(compute_name(element), compute_path(element), element.options) do
        @context.content_tag(:p, class: "text-sm font-medium text-gray-900 dark:text-yellow-400") do
          compute_name(element)
        end
      end
    end
  end
end
