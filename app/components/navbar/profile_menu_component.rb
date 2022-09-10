# frozen_string_literal: true

class Navbar::ProfileMenuComponent < ApplicationComponent
  def initialize(user:)
    @user = user
  end
end
