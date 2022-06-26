class LinksController < ApplicationController
  include LinksHelper
  before_action :authenticate_user!, except: %i[scan show]
  load_and_authorize_resource
  skip_authorize_resource only: %i[scan show]

  def index; end

  def show
    respond_to do |format|
      format.svg do
        @params = params.permit(:id, :format, :fill, :color)
        render inline: QrGenerator.gen(barcode_data(@link), fill: params[:fill] || @link.fill,
                                                            color: params[:color] || @link.color)
      end

      format.html do
        authenticate_user!
        authorize! :show, @link
        add_breadcrumb 'All links', links_path
        add_breadcrumb @link.name, @link
        render :show
      end
    end
  end

  def scan
    event = event_from_browser
    event.save
    redirect_to @link.barcode_data, allow_other_host: true
  end

  def new
    @link_type = request.query_parameters[:link_type]
    add_breadcrumb 'All links', links_path
    add_breadcrumb 'New link', new_link_path
  end

  def edit
    @link_type = @link.link_data.class.to_s.underscore
    add_breadcrumb 'All links', links_path
    add_breadcrumb @link.name, @link
    add_breadcrumb 'Edit', edit_link_path(@link)
  end

  def create
    respond_to do |format|
      if @link.save
        format.html { redirect_to links_url, success: 'Link was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: 'Link was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, success: 'Link was successfully destroyed.' }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:id, :name, :dynamic, :fill, :color,
                                 contact_link_attributes: %i[id first_name last_name phone email website company title address birthday note],
                                 email_link_attributes: %i[id email_address subject body],
                                 sms_link_attributes: %i[number body],
                                 telephone_link_attributes: [:number],
                                 url_link_attributes: %i[id url],
                                 wifi_link_attributes: %i[id ssid password hidden protocol])
  end

  def event_from_browser
    @link.events.new(
      browser_name: browser.name,
      browser_version: browser.version,
      bot_name: browser.bot.name,
      device_name: browser.device.name,
      platform_name: browser.platform.name,
      platform_version: browser.platform.version,
      language: browser.accept_language.first&.name,
      city: request.location.city,
      country: request.location.country
    )
  end
end
