# frozen_string_literal: true

class LinksController < ApplicationController
  include LinksHelper
  before_action :authenticate_user!, except: %i[scan challenge]
  load_and_authorize_resource
  before_action :set_instance_variables, only: %i[new edit]
  skip_before_action :redirect_if_inactive_subscription, only: %i[scan challenge]
  skip_before_action :redirect_if_not_onboarded, only: %i[scan challenge]

  def index
    @links = Link.accessible_by(current_ability).includes(LinkData::TYPES)
    @sort = params[:sort] || "desc"
    @links = @links.order(created_at: @sort)
    filter_links
    @paginated_links = @links.page params[:page]
  end

  def show
    respond_to do |format|
      format.html do
        add_breadcrumb "All links", links_path
        add_breadcrumb @link.name, @link
      end
    end
  end

  def scan
    redirect_to [:challenge, @link] and return if @link.password_digest

    process_scan
  end

  def challenge
    if request.patch?
      if @link.authenticate(params[:link][:password])
        process_scan
      else
        flash.now[:error] = "Incorrect password"
        render :challenge, layout: "empty", status: :unprocessable_entity
      end
    else
      render :challenge, layout: "empty"
    end
  end

  def new
    @styles = saved_styles
    add_breadcrumb "All links", links_path
    add_breadcrumb "New link", new_link_path
  end

  def edit
    @styles = saved_styles
    add_breadcrumb "All links", links_path
    add_breadcrumb @link.name, @link
    add_breadcrumb "Edit", edit_link_path(@link)
  end

  def create
    # Convert from hashid to id
    respond_to do |format|
      if @link.save
        ahoy.track "Link created", { name: @link.name, type: @link.link_type }
        format.html { redirect_to @link, success: "Link was successfully created." }
      else
        @link_type = @link.link_type
        @styles = saved_styles
        flash[:error] = @link.errors.full_messages.first
        format.html { render partial: "form", status: :unprocessable_entity, locals: { link: @link } }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: "Link was successfully updated." }
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
      flash[:success] = "Link was successfully archived."
      format.html { redirect_to links_url }
    end
  end

  def unarchive
    @link.unarchive!

    respond_to do |format|
      flash[:success] = "Link was successfully unarchived."
      format.html { redirect_to links_url }
    end
  end

  def confirm_remove_custom_domain
    render TurboModalComponent.new(title: "Remove custom domain from link").with_content(render_to_string(partial: "links/custom_domain/confirm_remove"))
  end

  def confirm_destroy
    @title = "Really delete?"
    @scans_text = @link.scans.count.positive? ? ", <b>including #{"#{@link.scans.count} #{'scan'.pluralize(@link.scans.count)}"}</b>".html_safe : ""
    render TurboModalComponent.new.with_content(render_to_string(partial: "links/confirm_destroy"))
  end

  def destroy
    @link.destroy

    respond_to do |format|
      flash[:success] = "Link was successfully destroyed."
      format.html { redirect_to links_url }
    end
  end

  def remove_custom_domain
    @link.custom_domain = nil
    @link.save
    flash[:info] = "Custom domain was removed from link."
    render partial: "links/password/password_field"
  end

  def remove_password
    @link.password_digest = nil
    @link.save!
    respond_to do |format|
      format.html do
        render partial: "links/password/password_field"
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
      :name, :dynamic, :password, :style, :custom_domain_id,
      contact_link_attributes: %i[id first_name last_name phone email website company title address birthday note],
      email_link_attributes: %i[id email_address subject body],
      sms_link_attributes: %i[id number body],
      telephone_link_attributes: %i[id number],
      url_link_attributes: %i[id url],
      wifi_link_attributes: %i[id ssid password hidden protocol]
    )
    if link_params[:custom_domain_id].present?
      link_params[:custom_domain_id] = CustomDomain.find(link_params[:custom_domain_id]).id
    end
    link_params.delete(:password) unless truthy?(link_params[:dynamic])
    link_params
  end

  def record_scan
    if do_not_track?
      record_anonymized_scan
    else
      record_tracked_scan
    end
  end

  def record_anonymized_scan
    @link.scans.create(
      browser_name: nil,
      browser_version: nil,
      bot_name: nil,
      device_name: nil,
      platform_name: nil,
      platform_version: nil,
      language: nil,
      city: nil,
      country: nil
    )
  end

  def record_tracked_scan
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

  def process_scan
    record_scan if @link.should_record_scan?
    case @link.link_type
    when "contact_link"
      send_data @link.barcode_data, filename: @link.name, type: :vcf, disposition: :inline
    else
      redirect_to(@link.barcode_data, status: :see_other, allow_other_host: true) and return
    end
  end

  def filter_links
    filter_by_status
    filter_by_search
  end

  def filter_by_status
    @show_archived = truthy?(params[:show_archived])
    @links = @links.where("archived_at is NULL") unless @show_archived
  end

  def filter_by_search
    @links = @links.where("name ILIKE :search", search: "%#{params[:search]}%")
  end
end
