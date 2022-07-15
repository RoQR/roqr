class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :continue_if_active

  def subscribe
    checkout_session = current_user.organization.payment_processor.checkout(
      mode: 'subscription',
      line_items: [{ price: checkout_params[:plan], quantity: 1 }],
      success_url: root_url,
      cancel_url: settings_organization_url
    )
    redirect_to checkout_session.url, allow_other_host: true, status: :see_other
  end

  def continue_if_active
    page_not_found unless Flipper.enabled? :stripe, current_user
  end

  private

  def checkout_params
    params.permit(:plan)
  end
end
