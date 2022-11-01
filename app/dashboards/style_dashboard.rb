require "administrate/base_dashboard"

class StyleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    background_color: Field::String,
    corner_dots_color: Field::String,
    corner_dots_shape: Field::String,
    corner_squares_color: Field::String,
    corner_squares_shape: Field::String,
    dots_color: Field::String,
    dots_shape: Field::String,
    image_url: Field::String,
    name: Field::String,
    organization: Field::BelongsTo,
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
    background_color
    corner_dots_color
    corner_dots_shape
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    background_color
    corner_dots_color
    corner_dots_shape
    corner_squares_color
    corner_squares_shape
    dots_color
    dots_shape
    image_url
    name
    organization
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    background_color
    corner_dots_color
    corner_dots_shape
    corner_squares_color
    corner_squares_shape
    dots_color
    dots_shape
    image_url
    name
    organization
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

  # Overwrite this method to customize how styles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(style)
  #   "Style ##{style.id}"
  # end
end
