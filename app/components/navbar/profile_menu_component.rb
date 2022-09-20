# frozen_string_literal: true

module Navbar
  class ProfileMenuComponent < ApplicationComponent
    def initialize(user:)
      @user = user
    end
  end
end
