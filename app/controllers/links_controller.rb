class LinksController < ApplicationController
  include LinksHelper
  include VersionsHelper
  before_action :authenticate_user!, except: %i[scan show]
  load_and_authorize_resource
  skip_authorize_resource only: %i[scan show]
  before_action :authenticate_before_scan, only: :scan

  def index; end

  def show
    respond_to do |format|
      format.svg do
        render inline: QrGenerator.gen(barcode_data(@link), fill: @link.fill, color: @link.color, position_border: @link.position_border_color,
                                                            position_core: @link.position_core_color)
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
    if @link.organization.payment_processor.on_trial_or_subscribed?
      scan = scan_from_browser
      scan.save
      @link.delay.report_scan_to_stripe
    end
    redirect_to(@link.barcode_data, allow_other_host: true) and return
  end

  def new
    @link_type = request.query_parameters[:link_type]
    @styles = allowed_styles
    add_breadcrumb 'All links', links_path
    add_breadcrumb 'New link', new_link_path
  end

  def edit
    @link_type = @link.link_data.class.to_s.underscore
    @styles = allowed_styles
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
        @link_type = @link.link_data.class.to_s.underscore
        flash[:error] = @link.errors.full_messages.first
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def confirm_destroy
    @scans_text = @link.scans.count.positive? ? ", <b>including #{@link.scans.count.to_s + ' ' + 'scan'.pluralize(@link.scans.count)}</b>".html_safe : ''
    render TurboModalComponent.new(title: 'Delete link').with_content(render_to_string(partial: 'links/confirm_destroy'))
  end

  def destroy
    @link.destroy

    respond_to do |format|
      flash[:success] = 'Link was successfully destroyed.'
      format.html { redirect_to links_url }
    end
  end

  private

  def allowed_styles
    Style.accessible_by(current_ability)
  end

  # Only allow a list of trusted parameters through.
  def link_params
    link_params = params.require(:link).permit(:id, :name, :dynamic, :password, :fill, :color, :position_border_color, :position_core_color,
                                               contact_link_attributes: %i[id first_name last_name phone email website company title address birthday note],
                                               email_link_attributes: %i[id email_address subject body],
                                               sms_link_attributes: %i[number body],
                                               telephone_link_attributes: [:number],
                                               url_link_attributes: %i[id url],
                                               wifi_link_attributes: %i[id ssid password hidden protocol])
    link_params.delete(:password) unless truthy?(link_params[:dynamic])
    link_params
  end

  def authenticate_before_scan
    return if @link.public?

    realm = "link-#{@link.id}"
    authenticate_or_request_with_http_basic(realm) do |_username, password|
      @link.authenticate(password)
    end
  end

  def scan_from_browser
    @link.scans.new(
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
