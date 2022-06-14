class LinksController < ApplicationController
  before_action :authenticate_user!, except: :scan
  load_and_authorize_resource
  skip_authorize_resource only: :scan

  # GET /links or /links.json
  def index
  end

  # GET /links/1 or /links/1.json
  def show
    add_breadcrumb "All links", links_path
    add_breadcrumb @link.name, @link 
  end

  def scan
    event = event_from_browser
    event.save
    redirect_to @link.link_data.barcode_data, allow_other_host: true
  end

  # GET /links/new
  def new
    add_breadcrumb "All links", links_path
    add_breadcrumb "New link", new_link_path
  end

  # GET /links/1/edit
  def edit
    add_breadcrumb "All links", links_path
    add_breadcrumb @link.name, @link
    add_breadcrumb "Edit", edit_link_path(@link)
  end

  # POST /links or /links.json
  def create
    respond_to do |format|
      if @link.save
        format.html { redirect_to links_url, success: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, success: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:id, :user_id, :name)
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
