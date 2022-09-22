# frozen_string_literal: true

class NavbarComponent < ApplicationComponent
  include IconsHelper
  include Turbo::StreamsHelper

  def initialize(user:)
    @user = user
  end
end
