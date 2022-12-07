class Marketing::QrController < ApplicationController
  layout "marketing"
  include Wicked::Wizard

  steps :type, :data, :style

  def show
    case step
    when :data
      @link_type = params[:link_type] || session.dig(:qr, "type")
      @qr = "Marketing::#{@link_type.camelize}".constantize.new
      session[:qr] = @qr.serializable_hash
    when :style
      @qr = "Marketing::#{session.dig(:qr, 'type').camelize}".constantize.new(session.dig(:qr).except("type"))
      @data = @qr.barcode_data
    end
    render_wizard
  end

  def update
    case step
    when :data
      @link_type = session.dig(:qr, "type")
      @qr = "Marketing::#{session.dig(:qr, 'type').camelize}".constantize.new
      @qr.assign_attributes(qr_params)
    end
    if @qr.valid?
      session[:qr] = @qr.serializable_hash
    else
      @qr.errors.full_messages.each do |message|
        flash.now[:error] = message
      end
    end
    render_wizard @qr
  end

  private

  def qr_params
    case @qr.type
    when :contact_link
      params.require(:marketing_contact_link).permit(:first_name, :last_name, :phone, :email, :website, :company,
                                                     :title, :address, :birthday, :note)
    when :email_link
      params.require(:marketing_email_link).permit(:email_address, :subject, :body)
    when :sms_link
      params.require(:marketing_sms_link).permit(:number, :body)
    when :telephone_link
      params.require(:marketing_telephone_link).permit(:number)
    when :url_link
      params.require(:marketing_url_link).permit(:url)
    when :wifi_link
      params.require(:marketing_wifi_link).permit(:ssid, :password, :hidden, :protocol)
    end
  end
end
