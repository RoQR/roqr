class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_resources

  def profile; end

  def organization
    return unless @organization.payment_processor.on_trial_or_subscribed?

    unless @organization.payment_processor.on_generic_trial?
    end
    @subscription = @organization.payment_processor.subscription
  end

  def settings; end

  private

  def load_resources
    @user = current_user
    @organization = current_user.organization
  end
end
