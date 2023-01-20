# frozen_string_literal: true

require "test_helper"

class PaddleWebhooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @pkey = OpenSSL::PKey::RSA.generate(1024)
    ENV["PADDLE_PUBLIC_KEY"] = @pkey.public_key.to_s
    @org = create(:organization)
    @user = create(:user, organization: @org)
    sign_in @user
    @user.confirm
  end

  test "should create subscription" do
    assert_difference("Subscription.count") do
      post paddle_webhooks_url, params: prepare_params(create_subscription_params)
    end
    assert_response :success
    assert @org.subscribed?
  end

  test "should create subscription payment" do
    post paddle_webhooks_url, params: create_subscription_params
    assert_difference("SubscriptionPayment.count") do
      post paddle_webhooks_url, params: prepare_params(create_successful_subscription_payment_params)
    end
    assert_response :success
  end

  test "should cancel subscription" do
    subscription = create(:subscription, organization: @org)
    post paddle_webhooks_url, params: prepare_params(cancel_subscription_params)
    assert_response :success
    subscription.reload
    assert_not_nil subscription.cancellation_effective_date
  end

  private

  def prepare_params(params)
    data = params.as_json
    data.each { |k, v| data[k] = String(v) }
    data = PHP.serialize(data, true)
    signature = @pkey.sign("SHA1", data)
    params[:p_signature] = Base64.encode64(signature)
    params
  end

  def create_subscription_params
    {
      alert_id: "1",
      alert_name: "subscription_created",
      cancel_url: "https://sandbox-subscription-management.paddle.com/subscription/340583/hash/157206376b15c2980df4215f2c6b5451c738a1d23d70125c87b99a71d08b2a7d/cancel",
      checkout_id: "1004128-chre99a3dc9e49b-8c79795bb1",
      currency: "USD",
      custom_data: "",
      email: "rollenseb@gmail.com",
      event_time: "2022-09-24 20:10:11",
      linked_subscriptions: "",
      marketing_consent: 0,
      next_bill_date: "2022-10-24",
      passthrough: @org.hashid,
      quantity: "1",
      source: "roqr.app / roqr.app",
      status: "active",
      subscription_id: "1",
      subscription_plan_id: "1",
      unit_price: "9.00",
      update_url: "https://sandbox-subscription-management.paddle.com/subscription/340583/hash/157206376b15c2980df4215f2c6b5451c738a1d23d70125c87b99a71d08b2a7d/update",
      user_id: "1"
    }
  end

  def create_successful_subscription_payment_params
    {
      alert_id: "2",
      alert_name: "subscription_payment_succeeded",
      balance_currency: "USD",
      balance_earnings: "7.94",
      balance_fee: "1.06",
      balance_gross: "11.25",
      balance_tax: "2.25",
      checkout_id: "1006892-chre0b76d5d1bd4-2348e77588",
      country: "SE",
      coupon: "",
      currency: "USD",
      custom_data: "",
      customer_name: "Test User",
      earnings: "7.94",
      email: "test@example.com",
      event_time: "2022-09-27 02:44:13",
      fee: "1.06",
      initial_payment: 1,
      instalments: "1",
      marketing_consent: 0,
      next_bill_date: "2022-10-27",
      next_payment_amount: "11.25",
      order_id: "437427-2928045",
      passthrough: @org.hashid,
      payment_method: "card",
      payment_tax: "2.25",
      plan_name: "10k scans",
      quantity: "1",
      receipt_url: "http://sandbox-my.paddle.com/receipt/437427-2928045/1006892-chre0b76d5d1bd4-2348e77588",
      sale_gross: "11.25",
      status: "active",
      subscription_id: "1",
      subscription_payment_id: "1",
      subscription_plan_id: "1",
      unit_price: "9.00",
      user_id: "1"
    }
  end

  def cancel_subscription_params
    {
      alert_id: "3",
      alert_name: "subscription_cancelled",
      cancellation_effective_date: Time.zone.now + 30.days,
      checkout_id: "1",
      currency: "USD",
      custom_data: "",
      email: "test@example.com",
      event_time: Time.zone.now,
      linked_subscriptions: "",
      marketing_consent: 0,
      passthrough: "1",
      quantity: "1",
      status: "deleted",
      subscription_id: "2",
      subscription_plan_id: "2",
      unit_price: "9.00",
      user_id: "1"
    }
  end
end
