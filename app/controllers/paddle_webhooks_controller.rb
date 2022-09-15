class PaddleWebhooksController < ApplicationController
  before_action :verify_webhook, unless: -> { Rails.env.test? }
  skip_before_action :verify_authenticity_token

  def create
    case params[:alert_name]
    when 'subscription_created'
      subscription_created
    when 'subscription_updated'
      subscription_updated
    when 'subscription_cancelled'
      subscription_cancelled
    when 'subscription_payment_succeeded'
    when 'subscription_payment_failed'
    when 'subscription_payment_refunded'
    end
  end

  def subscription_created
    organization = Organization.find(params[:passthrough])
    organization.build_subscription(paddle_subscription_params)
    respond_to do |format|
      if organization.save
        format.html { head 200 }
      else
        format.html { head 500 }
      end
    end
  end

  def subscription_updated
    organization = Organization.find(params[:passthrough])
    respond_to do |format|
      if organization.subscription.update(paddle_subscription_params)
        format.html { head 200 }
      else
        format.html { head 500 }
      end
    end
  end

  def subscription_cancelled
    organization = Organization.find(params[:passthrough])
    respond_to do |format|
      if organization.subscription.update(paddle_cancellation_params)
        format.html { head 200 }
      else
        format.html { head 500 }
      end
    end
  end

  private

  def verify_webhook
    public_key = ENV['PADDLE_PUBLIC_KEY']
    data = params.as_json
    signature = Base64.decode64(data['p_signature'])
    data.delete('p_signature')
    data.delete('controller')
    data.delete('action')
    data.each { |key, value| data[key] = String(value) }
    params_sorted = data.sort_by { |key, _value| key }
    params_serialized = PHP.serialize(params_sorted, true)

    digest = OpenSSL::Digest.new('SHA1')
    pub_key = OpenSSL::PKey::RSA.new(public_key).public_key

    return head(403) unless pub_key.verify(digest, signature, params_serialized)
  end

  def paddle_subscription_params
    params.permit(:subscription_id, :subscription_plan_id, :status, :update_url, :cancel_url, :next_bill_date)
  end

  def paddle_cancellation_params
    params.permit(:subscription_id, :subscription_plan_id, :status, :cancellation_effective_date)
  end
end
