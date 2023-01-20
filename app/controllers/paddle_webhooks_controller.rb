# frozen_string_literal: true

class PaddleWebhooksController < ApplicationController
  before_action :verify_webhook, unless: -> { Rails.env.test? }
  skip_before_action :verify_authenticity_token
  skip_before_action :redirect_if_inactive_subscription
  skip_before_action :redirect_if_not_onboarded

  def create
    case params[:alert_name]
    when "subscription_created"
      subscription_created
    when "subscription_updated"
      subscription_updated
    when "subscription_cancelled"
      subscription_cancelled
    when "subscription_payment_succeeded"
      subscription_payment_succeeded
    when "subscription_payment_failed"
      subscription_payment_failed
    when "subscription_payment_refunded"
    end
  end

  def subscription_created
    organization = Organization.find(params[:passthrough])
    organization.build_subscription(paddle_subscription_params)
    if organization.save
      ahoy.track "Subscription created", { organization_id: organization.id }
      head 200
    else
      head 500
    end
  end

  def subscription_updated
    subscription = Subscription.find_by_paddle_subscription_id(params[:subscription_id])
    if subscription.update(paddle_subscription_params)
      ahoy.track "Subscription updated", { organization_id: subscription.organization.id }
      head 200
    else
      head 500
    end
  end

  def subscription_cancelled
    subscription = Subscription.find_by_paddle_subscription_id(params[:subscription_id])
    # If the user deleted their organization, the subscription will be gone too, but we will still receive the webhook.
    # We should still be nice citizens and return 200 as otherwise Paddle will resend the webhook.
    return head 200 if subscription.nil?

    if subscription.update(paddle_cancellation_params)
      ahoy.track "Subscription cancelled", { organization_id: subscription.organization.id }
      head 200
    else
      head 500
    end
  end

  def subscription_payment_succeeded
    subscription = Subscription.find_by_paddle_subscription_id(params[:subscription_id])
    subscription.assign_attributes(paddle_subscription_params)
    subscription.subscription_payments.find_or_initialize_by(
      paddle_subscription_payment_id: params[:subscription_payment_id]
    ) do |s|
      s.assign_attributes(paddle_subscription_payment_params)
    end
    if subscription.save
      ahoy.track "Subscription payment received", { organization_id: subscription.organization.id }
      head 200
    else
      head 500
    end
  end

  def subscription_payment_failed
    subscription = Subscription.find_by_paddle_subscription_id(params[:subscription_id])
    subscription.assign_attributes(paddle_subscription_params)
    subscription.subscription_payments.find_or_initialize_by(
      paddle_subscription_payment_id: params[:subscription_payment_id]
    ) do |s|
      s.assign_attributes(paddle_subscription_payment_params)
    end
    if subscription.save
      ahoy.track "Subscription payment failed", { organization_id: subscription.organization.id }
      head 200
    else
      head 500
    end
  end

  private

  def verify_webhook
    signature = Base64.decode64(params["p_signature"])
    params_serialized = prepare_params

    return head(403) unless public_key.verify(OpenSSL::Digest.new("SHA1"), signature, params_serialized)
  end

  def prepare_params
    data = params.as_json
    %w[p_signature controller action].each { |k| data.delete(k) }
    data.each { |key, value| data[key] = String(value) }
    params_sorted = data.sort_by { |key, _value| key }
    PHP.serialize(params_sorted, true)
  end

  def public_key
    public_key = Rails.application.credentials.dig(:paddle, :public_key) || ENV.fetch("PADDLE_PUBLIC_KEY", nil)
    OpenSSL::PKey::RSA.new(public_key).public_key
  end

  def paddle_subscription_params
    params.permit(:subscription_id, :subscription_plan_id, :status, :update_url, :cancel_url, :next_bill_date)
  end

  def paddle_cancellation_params
    params.permit(:subscription_id, :subscription_plan_id, :status, :cancellation_effective_date)
  end

  def paddle_subscription_payment_params
    params.permit(:currency, :event_time, :payment_method, :receipt_url, :sale_gross)
  end
end
