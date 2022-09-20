# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def new
    @plans = PaddlePay::Subscription::Plan.list
  end
end
