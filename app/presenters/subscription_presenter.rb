class SubscriptionPresenter
  def initialize(subscription)
    @subscription = subscription
  end

  def status_badge
    color = case @subscription.status
            when 'active'
              'bg-green-100 text-green-800'
            when 'deleted'
              'bg-gray-100 text-gray-800'
            end
    content_tag :span, @subscription.status,
                class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium #{color}"
  end
end
