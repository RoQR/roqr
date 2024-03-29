# frozen_string_literal: true

class SubscriptionPresenter
  include ActionView::Helpers::TagHelper
  def initialize(subscription)
    @subscription = subscription
  end

  def status_badge
    status = @subscription.status
    color = case @subscription.status
            when "active", "trialing"
              "bg-green-100 text-green-800"
            when "past_due"
              "bg-red-100 text-red-800"
            when "paused", "cancelled"
              "bg-gray-100 text-gray-800"
            end
    content_tag :span, status.titlecase,
                class: "ml-3 inline-flex items-center rounded-sm px-2.5 py-0.5 text-xs font-medium #{color}"
  end
end
