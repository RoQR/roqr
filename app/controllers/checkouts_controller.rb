class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @checkout_session = current_user.organization.payment_processor.checkout(
      mode: 'subscription',
      line_items: %w[solo_artist]
    )
  end
end
