# frozen_string_literal: true

module Api
  module V1
    class ScansController < Api::V1::BaseController
      load_and_authorize_resource

      def index
        current_user.requests.create(method: :get, requestable_type: "Event")
      end
    end
  end
end
