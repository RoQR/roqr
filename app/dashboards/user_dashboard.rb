require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    confirmation_sent_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    email: Field::String,
    encrypted_password: Field::String,
    invitation_accepted_at: Field::DateTime,
    invitation_created_at: Field::DateTime,
    invitation_limit: Field::Number,
    invitation_sent_at: Field::DateTime,
    invitation_token: Field::String,
    invitations_count: Field::Number,
    invited_by: Field::Polymorphic,
    name: Field::String,
    notifications: Field::HasMany,
    organization: Field::BelongsTo,
    private_api_key_bidx: Field::String,
    private_api_key_ciphertext: Field::Text,
    provider: Field::String,
    remember_created_at: Field::DateTime,
    requests: Field::HasMany,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    role: Field::Select.with_options(searchable: false, collection: lambda { |field|
                                                                      field.resource.class.send(field.attribute.to_s.pluralize).keys
                                                                    }),
    uid: Field::String,
    unconfirmed_email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    locked_at: Field::DateTime,
    failed_attempts: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    email
    organization
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    email
    organization
    role
    unconfirmed_email
    confirmation_sent_at
    confirmation_token
    confirmed_at
    invitation_accepted_at
    invitation_created_at
    invitation_limit
    invitation_sent_at
    invitation_token
    invitations_count
    invited_by
    notifications
    provider
    requests
    reset_password_sent_at
    reset_password_token
    created_at
    updated_at
    locked_at
    failed_attempts
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    email
    name
    organization
    role
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

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
