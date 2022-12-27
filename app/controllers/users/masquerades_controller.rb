# frozen_string_literal: true

module Users
  class MasqueradesController < Devise::MasqueradesController
    skip_before_action :redirect_if_inactive_subscription

    protected

    def after_back_masquerade_path_for(_resource)
      "/admin"
    end
  end
end
