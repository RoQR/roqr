# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from CanCan::AccessDenied, with: :unauthorized
      protect_from_forgery with: :null_session
      skip_before_action :track_ahoy_visit
      skip_before_action :redirect_if_inactive_subscription
      skip_before_action :redirect_if_not_onboarded

      private

      def unauthorized
        render json: { message: "Unauthorized" }, status: :unauthorized
      end

      def handle_not_found
        render json: { message: "Record not found" }, status: :not_found
      end
    end
  end
end
