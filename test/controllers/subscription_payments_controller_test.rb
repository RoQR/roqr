require "test_helper"

class SubscriptionPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription_payment = subscription_payments(:one)
  end

  test "should get index" do
    get subscription_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_subscription_payment_url
    assert_response :success
  end

  test "should create subscription_payment" do
    assert_difference("SubscriptionPayment.count") do
      post subscription_payments_url, params: { subscription_payment: { currency: @subscription_payment.currency, event_time: @subscription_payment.event_time, payment_method: @subscription_payment.payment_method, receipt_url: @subscription_payment.receipt_url, sale_gross: @subscription_payment.sale_gross, subscription_id: @subscription_payment.subscription_id } }
    end

    assert_redirected_to subscription_payment_url(SubscriptionPayment.last)
  end

  test "should show subscription_payment" do
    get subscription_payment_url(@subscription_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_subscription_payment_url(@subscription_payment)
    assert_response :success
  end

  test "should update subscription_payment" do
    patch subscription_payment_url(@subscription_payment), params: { subscription_payment: { currency: @subscription_payment.currency, event_time: @subscription_payment.event_time, payment_method: @subscription_payment.payment_method, receipt_url: @subscription_payment.receipt_url, sale_gross: @subscription_payment.sale_gross, subscription_id: @subscription_payment.subscription_id } }
    assert_redirected_to subscription_payment_url(@subscription_payment)
  end

  test "should destroy subscription_payment" do
    assert_difference("SubscriptionPayment.count", -1) do
      delete subscription_payment_url(@subscription_payment)
    end

    assert_redirected_to subscription_payments_url
  end
end
