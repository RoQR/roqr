# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  include IconsHelper
  include UsersHelper

  def initialize(user:)
    @user = user
  end
end
