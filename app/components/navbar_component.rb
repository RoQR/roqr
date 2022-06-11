# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  include ApplicationHelper
  include UsersHelper

  def initialize(user:)
    @user = user
  end
end
