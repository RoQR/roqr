require 'application_system_test_case'

class SubscriptionPaymentsTest < ApplicationSystemTestCase
  setup do
    @subscription_payment = subscription_payments(:one)
  end

  test 'visiting the index' do
    visit subscription_payments_url
    assert_selector 'h1', text: 'Subscription payments'
  end

  test 'should create subscription payment' do
    visit subscription_payments_url
    click_on 'New subscription payment'

    fill_in 'Currency', with: @subscription_payment.currency
    fill_in 'Event time', with: @subscription_payment.event_time
    fill_in 'Payment method', with: @subscription_payment.payment_method
    fill_in 'Receipt url', with: @subscription_payment.receipt_url
    fill_in 'Sale gross', with: @subscription_payment.sale_gross
    fill_in 'Subscription', with: @subscription_payment.subscription_id
    click_on 'Create Subscription payment'

    assert_text 'Subscription payment was successfully created'
    click_on 'Back'
  end

  test 'should update Subscription payment' do
    visit subscription_payment_url(@subscription_payment)
    click_on 'Edit this subscription payment', match: :first

    fill_in 'Currency', with: @subscription_payment.currency
    fill_in 'Event time', with: @subscription_payment.event_time
    fill_in 'Payment method', with: @subscription_payment.payment_method
    fill_in 'Receipt url', with: @subscription_payment.receipt_url
    fill_in 'Sale gross', with: @subscription_payment.sale_gross
    fill_in 'Subscription', with: @subscription_payment.subscription_id
    click_on 'Update Subscription payment'

    assert_text 'Subscription payment was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Subscription payment' do
    visit subscription_payment_url(@subscription_payment)
    click_on 'Destroy this subscription payment', match: :first

    assert_text 'Subscription payment was successfully destroyed'
  end
end
