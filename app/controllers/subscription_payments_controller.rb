# frozen_string_literal: true

class SubscriptionPaymentsController < ApplicationController
  before_action :set_subscription_payment, only: %i[show edit update destroy]
  skip_before_action :redirect_if_inactive_subscription

  # GET /subscription_payments
  def index
    @subscription_payments = SubscriptionPayment.all
  end

  # GET /subscription_payments/1
  def show; end

  # GET /subscription_payments/new
  def new
    @subscription_payment = SubscriptionPayment.new
  end

  # GET /subscription_payments/1/edit
  def edit; end

  # POST /subscription_payments
  def create
    @subscription_payment = SubscriptionPayment.new(subscription_payment_params)

    if @subscription_payment.save
      redirect_to subscription_payment_url(@subscription_payment),
                  notice: "Subscription payment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subscription_payments/1
  def update
    respond_to do |format|
      if @subscription_payment.update(subscription_payment_params)
        format.html do
          redirect_to subscription_payment_url(@subscription_payment),
                      notice: "Subscription payment was successfully updated."
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscription_payments/1
  def destroy
    @subscription_payment.destroy

    respond_to do |format|
      format.html { redirect_to subscription_payments_url, notice: "Subscription payment was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup
  def set_subscription_payment
    @subscription_payment = SubscriptionPayment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subscription_payment_params
    params.require(:subscription_payment).permit(:subscription_id, :currency, :event_time, :payment_method,
                                                 :receipt_url, :sale_gross)
  end
end
