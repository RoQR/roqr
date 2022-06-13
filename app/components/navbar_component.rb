# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  include IconHelper
  include UsersHelper

  def initialize(user:)
    @user = user
  end
end
