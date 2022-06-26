class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :continue_if_active

  def index
    @processor = current_user.organization.payment_processor
  end

  def continue_if_active
    page_not_found unless Flipper.active? :stripe, current_user
  end
end
