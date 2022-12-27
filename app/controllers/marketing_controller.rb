# frozen_string_literal: true

class MarketingController < ApplicationController
  layout "marketing"
  skip_before_action :redirect_if_inactive_subscription
  def index; end

  def terms_of_service; end
end
