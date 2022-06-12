module BreadcrumbsHelper
  class RoqrBreadcrumbs < BreadcrumbsOnRails::Breadcrumbs::Builder
    include ApplicationHelper
    include ERB::Util

    def chevron
      File.open("app/assets/images/solid-chevron-right.svg", "rb") do |file|
        file.read
      end
    end

    def render
      @context.content_tag(:div, class: 'mt-3 flex items-center space-x-1 sm:space-x-3') do
        separator = chevron
        @elements.collect do |element|
          html_escape(render_element(element))
        end.join(separator).html_safe
      end
    end

    def render_element(element)
      if element.path == nil
        content = compute_name(element)
      else
        element.options.merge!({ class: 'text-sm font-medium text-gray-500 hover:text-gray-700'})
        content = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options) do
          @context.content_tag(:p, class: 'text-sm font-medium text-gray-500') do
            compute_name(element)
          end
        end
          
      end
      if @options[:tag]
        @context.content_tag(@options[:tag], content)
      else
        ERB::Util.h(content)
      end
    end
  end
end
