# frozen_string_literal: true

class LinksController < ApplicationController
  include LinksHelper
  include VersionsHelper
  before_action :authenticate_user!, except: %i[scan show]
  load_and_authorize_resource
  before_action :authenticate_before_scan, only: :scan
  before_action :set_instance_variables, only: %i[new edit]

  def index
    @links = Link.active.accessible_by(current_ability).includes(LinkData::TYPES)
    @archived_links = Link.archived.accessible_by(current_ability).includes(LinkData::TYPES)
  end

  def show
    respond_to do |format|
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
    if @link.should_record_scan? && !do_not_track?
      record_scan
      FirstScanNotification.with(link_name: @link.name).deliver_later(@link.organization.users) if @link.scans.size == 1
    end
    case @link.link_type
    when 'contact_link'
      send_data @link.barcode_data, filename: @link.name, type: :vcf, disposition: :inline
    else
      redirect_to(@link.barcode_data, allow_other_host: true) and return
    end
  end

  def new
    @styles = saved_styles
    add_breadcrumb 'All links', links_path
    add_breadcrumb 'New link', new_link_path
  end

  def edit
    @styles = saved_styles
    add_breadcrumb 'All links', links_path
    add_breadcrumb @link.name, @link
    add_breadcrumb 'Edit', edit_link_path(@link)
  end

  def create
    debugger
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, success: 'Link was successfully created.' }
      else
        @link_type = @link.link_type
        @styles = saved_styles
        flash[:error] = @link.errors.full_messages.first
        format.html { render partial: 'form', status: :unprocessable_entity, locals: { link: @link } }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: 'Link was successfully updated.' }
      else
        @link_type = @link.link_data.class.to_s.underscore
        @styles = saved_styles
        flash[:error] = @link.errors.full_messages.first
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @link.archive!

    respond_to do |format|
      flash[:success] = 'Link was successfully archived.'
      format.html { redirect_to links_url }
    end
  end

  def confirm_destroy
    @scans_text = @link.scans.count.positive? ? ", <b>including #{"#{@link.scans.count} #{'scan'.pluralize(@link.scans.count)}"}</b>".html_safe : ''
    render TurboModalComponent.new(title: 'Delete link').with_content(render_to_string(partial: 'links/confirm_destroy'))
  end

  def destroy
    @link.destroy

    respond_to do |format|
      flash[:success] = 'Link was successfully destroyed.'
      format.html { redirect_to links_url }
    end
  end

  def remove_password
    @link.password_digest = nil
    @link.save!
    respond_to do |format|
      format.html do
        render partial: 'links/password/password_field'
      end
    end
  end

  private

  def saved_styles
    Style.accessible_by(current_ability)
  end

  # Only allow a list of trusted parameters through.
  def link_params
    link_params = params.require(:link).permit(
      :name, :dynamic, :password, :background_color, :dots_color,
      :dots_shape, :corner_dots_color, :corner_dots_shape, :corner_squares_color, :corner_squares_shape, :image_url,
      contact_link_attributes: %i[first_name last_name phone email website company title address birthday note],
      email_link_attributes: %i[email_address subject body],
      sms_link_attributes: %i[number body],
      telephone_link_attributes: [:number],
      url_link_attributes: %i[url],
      wifi_link_attributes: %i[ssid password hidden protocol]
    )
    link_params.delete(:password) unless truthy?(link_params[:dynamic])
    link_params
  end

  def authenticate_before_scan
    return if @link.public?

    realm = "link-#{@link.hashid}"
    authenticate_or_request_with_http_basic(realm) do |_username, password|
      @link.authenticate(password)
    end
  end

  def record_scan
    @link.scans.create(
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

  def set_instance_variables
    @link_type = params[:link_type] || @link.link_data&.class&.to_s&.underscore
    @static_only = @link_type.camelcase.constantize.static_only? if @link_type
  end
end
