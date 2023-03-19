# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_resources

  def profile
  end

  def organization
  end

  def subscription
    return unless @organization.subscribed?

    @subscription_payments = @organization.subscription.subscription_payments.order(created_at: :desc).page params[:page]
    @last_payment_date = @subscription_payments.pluck(:event_time).max
    @num_scans = Scan.accessible_by(current_ability).where("created_at > ?", @last_payment_date).count
  end

  def settings
  end

  private

  def load_resources
    @user = current_user
    @organization = current_user.organization
  end
end
