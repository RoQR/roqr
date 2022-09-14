class PaddleWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts params
  end

  private

  def paddle_webhooks_params
    params.permit!
  end
end
