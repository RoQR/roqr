# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  skip_before_action :redirect_if_inactive_subscription
  skip_before_action :redirect_if_not_onboarded

  def new
    @plans = PaddlePay::Subscription::Plan.list
    @current_plan = current_user.organization.subscription
  end

  def edit
    @plans = PaddlePay::Subscription::Plan.list
  end

  def subscribed
    flash["success"] =
      { title: "Subscription created successfully.",
        body: "Please allow up to 5 minutes for the payment to process and the subscription to be activated", timeout: 60, countdown: true }
    redirect_to settings_subscription_path
  end

  def preview
    @preview = PaddlePay::Subscription::User.preview_update(@subscription.paddle_subscription_id,
                                                            { plan_id: params.dig(:subscription, :plan_id),
                                                              prorate: true, bill_immediately: true })
  end

  def update
    PaddlePay::Subscription::User.update(@subscription.paddle_subscription_id,
                                         { plan_id: params.dig(:subscription, :plan_id), prorate: true,
                                           bill_immediately: true })
    flash["success"] = "Plan change request submitted successfully."
    redirect_to settings_organization_path
  rescue PaddlePay::PaddlePayError
    @plans = PaddlePay::Subscription::Plan.list
    flash.now[:error] = "Error processing plan change request."
    render :edit, status: :unprocessable_entity
  end
end
