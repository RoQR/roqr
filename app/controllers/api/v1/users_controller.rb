# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      load_and_authorize_resource

      def show
        @user.requests.create(method: :get, requestable_type: :User)
      end

      def update
        @user.requests.create(method: :put, requestable_type: :User)
        if @user.update(user_params)
          render :show, status: :ok
        else
          render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.requests.create(method: :delete, requestable_type: :User)
        @user.destroy
        render :show, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:id, :name, :email)
      end
    end
  end
end
