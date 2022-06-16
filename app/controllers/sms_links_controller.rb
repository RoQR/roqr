class SmsLinksController < ApplicationController
  include LinkDataConcern

  private

    # Only allow a list of trusted parameters through.
    def sms_link_params
      params.require(:sms_link).permit(:id, :number, :body, links_attributes: [:id, :user_id, :name, :dynamic])
    end
end
