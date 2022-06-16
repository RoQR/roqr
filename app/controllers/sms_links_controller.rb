class SmsLinksController < ApplicationController
  include LinkDataConcern

  private

  def link_data_params
    sms_link_params
  end

  # Only allow a list of trusted parameters through.
  def sms_link_params
    params.require(:sms_link).permit(:id, :number, :body, links_attributes: [:id, :user_id, :name, :dynamic])
  end
end
