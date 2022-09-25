# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def new
    @plans = PaddlePay::Subscription::Plan.list
    @current_plan = current_user.organization.subscription
  end

  def edit
    @plans = PaddlePay::Subscription::Plan.list
    @current_plan = current_user.organization.subscription
  end

  def update
    subscription = Subscription.find(params[:id])
    begin
      PaddlePay::Subscription::User.update(subscription.paddle_subscription_id,
                                           { plan_id: params.dig(:subscription, :plan_id) })
      flash['success'] = 'Plan change request submitted successfully.'
      redirect_to settings_organization_path
    rescue PaddlePay::PaddlePayError
      @plans = PaddlePay::Subscription::Plan.list
      @current_plan = current_user.organization.subscription
      flash.now[:error] = 'Error processing plan change request.'
      render :edit, status: :unprocessable_entity
    end
  end
end
