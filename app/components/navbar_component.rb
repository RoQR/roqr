# frozen_string_literal: true

class NavbarComponent < ApplicationComponent
  include IconsHelper

  def initialize(user:)
    @user = user
  end
end
