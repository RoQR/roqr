class PlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @processor = current_user.organization.payment_processor
  end
end
