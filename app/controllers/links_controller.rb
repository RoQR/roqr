class LinksController < ApplicationController
  before_action :authenticate_user!, except: :scan
  load_and_authorize_resource
  skip_authorize_resource only: :scan

  def index
  end

  def show
    add_breadcrumb "All links", links_path
    add_breadcrumb @link.name, @link 
  end

  def scan
    event = event_from_browser
    event.save
    redirect_to @link.barcode_data, allow_other_host: true
  end

  def new
    add_breadcrumb "All links", links_path
    add_breadcrumb "New link", new_link_path
  end

  def edit
    add_breadcrumb "All links", links_path
    add_breadcrumb @link.name, @link
    add_breadcrumb "Edit", edit_link_path(@link)
  end

  def create
    respond_to do |format|
      if @link.save
        format.html { redirect_to links_url, success: "Link was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: "Link was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, success: "Link was successfully destroyed." }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:id, :user_id, :name, :dynamic, url_link_attributes: [:id, :url])
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
        country: request.location.country,
        ip: request.remote_ip
      )
    end
end
