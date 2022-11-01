require "administrate/base_dashboard"

class SubscriptionPaymentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    currency: Field::String,
    event_time: Field::DateTime,
    paddle_subscription_payment_id: Field::Number,
    payment_method: Field::String,
    receipt_url: Field::String,
    sale_gross: Field::String,
    subscription: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    currency
    event_time
    paddle_subscription_payment_id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    currency
    event_time
    paddle_subscription_payment_id
    payment_method
    receipt_url
    sale_gross
    subscription
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    currency
    event_time
    paddle_subscription_payment_id
    payment_method
    receipt_url
    sale_gross
    subscription
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how subscription payments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(subscription_payment)
  #   "SubscriptionPayment ##{subscription_payment.id}"
  # end
end
