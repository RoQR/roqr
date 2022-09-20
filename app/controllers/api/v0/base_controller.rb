class Api::V0::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from CanCan::AccessDenied, with: :unauthorized
  protect_from_forgery with: :null_session

  private

  def unauthorized
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end

  def handle_not_found
    render json: { message: 'Record not found' }, status: :not_found
  end
end
