# frozen_string_literal: true

class Navbar::ProfileMenuComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end
end
