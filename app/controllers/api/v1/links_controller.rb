# frozen_string_literal: true

module Api
  module V1
    class LinksController < Api::V1::BaseController
      load_and_authorize_resource

      def index
        current_user.requests.create(method: :get, requestable_type: "Link")
      end

      def show
        current_user.requests.create(method: :get, requestable_type: "Link")
      end

      def create
        current_user.requests.create(method: :post, requestable_type: "Link")
        if @link.save
          render :show, status: :created
        else
          render json: { message: @link.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        current_user.requests.create(method: :put, requestable_type: "Link")
        if @link.update(link_params)
          render :show, status: :ok
        else
          render json: { message: @link.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def archive
        current_user.requests.create(method: :post, requestable_type: "Link")
        @link.archive!
        render :show, status: :ok
      end

      def unarchive
        current_user.requests.create(method: :post, requestable_type: "Link")
        @link.unarchive!
        render :show, status: :ok
      end

      def destroy
        current_user.requests.create(method: :delete, requestable_type: "Link")
        @link.destroy
        render :show, status: :ok
      end

      private

      def link_data_params
        case params[:data][:type]
        when "contact"
          { contact_link_attributes: params.require(:data).permit(
            :first_name, :last_name, :birthday, :company, :title, :phone, :email, :website, :address, :note
          ) }
        when "email"
          { email_link_attributes: params.require(:data).permit(:email_address, :subject, :body) }
        when "sms"
          { sms_link_attributes: params.require(:data).permit(:number, :body) }
        when "telephone"
          { telephone_link_attributes: params.require(:data).permit(:number) }
        when "wifi"
          { wifi_link_attributes: params.require(:data).permit(:ssid, :password, :protocol) }
        when "url"
          { url_link_attributes: params.require(:data).permit(:url) }
        end
      end

      def link_params
        params.permit(
          :name, :dynamic
        ).merge(link_data_params)
      end
    end
  end
end
