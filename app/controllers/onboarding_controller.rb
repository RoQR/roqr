class OnboardingController < ApplicationController
  skip_before_action :redirect_if_not_onboarded
  include Wicked::Wizard

  layout "onboarding"
  steps :terms_of_service, :link, :scan

  def show
    case step
    when :link
      @link = Link.new
    when :scan
      @link = Link.accessible_by(current_ability).last
    end
    render_wizard
  end

  def update
    case step
    when :terms_of_service
      @resource = current_user
      @resource.assign_attributes(user_params)
    when :link
      @resource = current_user.organization.links.new(link_params)
    end
    flash[:error] = @resource.errors.full_messages.first unless @resource.valid?
    render_wizard @resource
  end

  private

  def user_params
    params.require(:user).permit(:terms_accepted)
  end

  def link_params
    params.require(:link).permit(:name, url_link_attributes: %i[id url]).with_defaults(name: "My first link")
  end

  def finish_wizard_path
    links_path
  end
end
