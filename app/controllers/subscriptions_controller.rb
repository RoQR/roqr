# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  def new
    @plans = PaddlePay::Subscription::Plan.list
    @current_plan = current_user.organization.subscription
  end

  def edit
    @plans = PaddlePay::Subscription::Plan.list
  end

  def update
    PaddlePay::Subscription::User.update(subscription.paddle_subscription_id,
                                         { plan_id: params.dig(:subscription, :plan_id) })
    flash['success'] = 'Plan change request submitted successfully.'
    redirect_to settings_organization_path
  rescue PaddlePay::PaddlePayError
    @plans = PaddlePay::Subscription::Plan.list
    flash.now[:error] = 'Error processing plan change request.'
    render :edit, status: :unprocessable_entity
  end
end
