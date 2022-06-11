class LinksController < ApplicationController
  before_action :authenticate_user!, except: :scan
  load_and_authorize_resource

  # GET /links or /links.json
  def index
  end

  # GET /links/1 or /links/1.json
  def show
  end

  def scan
    event = event_from_browser
    redirect_to @link.url, allow_other_host: true
  end

  # GET /links/new
  def new
  end

  # GET /links/1/edit
  def edit
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
      params.require(:link).permit(:id, :user_id, :url, :name)
    end

    def event_from_browser
      @link.events.create(
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
