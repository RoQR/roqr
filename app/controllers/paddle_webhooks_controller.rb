class PaddleWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    case params[:alert_name]
    when 'subscription_created'
      subscription_created
    when 'subscription_updated'
    when 'subscription_cancelled'
    when 'subscription_payment_succeeded'
    when 'subscription_payment_failed'
    when 'subscription_payment_refunded'
    end
  end

  def subscription_created
    organization = Organization.find(params[:passthrough])
    organization.paddle_subscription_id = params[:subscription_id]
    organization.paddle_update_url = params[:update_url]
    organization.paddle_cancel_url = params[:cancel_url]
    organization.paddle_status = params[:status]
    organization.paddle_next_bill_date = params[:next_bill_date]
    organization.save
  end

  private

  def paddle_webhooks_params
    params.permit!
  end
end
