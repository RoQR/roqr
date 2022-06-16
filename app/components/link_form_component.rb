# frozen_string_literal: true

class LinkFormComponent < ViewComponent::Base
  attr_reader :form

  def initialize(form:, user:, static_only: false)
    @form = form
    @user = user
    @static_only = static_only
  end

  # https://github.com/github/view_component/pull/240#issuecomment-950159559
  def render_in(view_context, &block)
    old_form_view_context = form.instance_variable_get('@template')
    form.instance_variable_set('@template', self)
    super(view_context, &block)
  ensure
    form.instance_variable_set('@template', old_form_view_context)
  end
end
