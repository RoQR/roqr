# frozen_string_literal: true

module Api
  module V0
    class LinksController < Api::V0::BaseController
      load_and_authorize_resource

      def index
        current_user.requests.create(method: :get, requestable_type: 'Link')
      end

      def show
        current_user.requests.create(method: :get, requestable_type: 'Link')
      end

      def create
        current_user.requests.create(method: :post, requestable_type: 'Link')
        if @link.save
          render :show, status: :created
        else
          render json: { message: @link.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        current_user.requests.create(method: :put, requestable_type: 'Link')
        if @link.update(link_params)
          render :show, status: :ok
        else
          render json: { message: @link.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        current_user.requests.create(method: :delete, requestable_type: 'Link')
        @link.destroy
        render :show, status: :ok
      end

      private

      def link_params
        params.require(:link).permit(
          :id, :name, :dynamic,
          contact_link_attributes: %i[id first_name last_name phone email website company title address birthday note],
          email_link_attributes: %i[id email_address subject body],
          sms_link_attributes: %i[number body],
          telephone_link_attributes: [:number],
          url_link_attributes: %i[id url],
          wifi_link_attributes: %i[id ssid password hidden protocol]
        )
      end
    end
  end
end
