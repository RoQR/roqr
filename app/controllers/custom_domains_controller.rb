class CustomDomainsController < ApplicationController
  load_and_authorize_resource :organization
  load_and_authorize_resource :custom_domain, through: :organization, shallow: true
  # GET /custom_domains or /custom_domains.json
  def index; end

  # GET /custom_domains/1 or /custom_domains/1.json
  def show
    add_breadcrumb "Organization settings", settings_organization_path
  end

  # GET /custom_domains/new
  def new; end

  # GET /custom_domains/1/edit
  def edit; end

  def check
    Fly::CheckCustomDomainJob.perform_later(@custom_domain)
    render partial: "custom_domains/check_button/loading"
  end

  # POST /custom_domains or /custom_domains.json
  def create
    respond_to do |format|
      if @custom_domain.save
        format.html { redirect_to settings_organization_path, notice: "Custom domain was successfully created." }
        format.json { render :show, status: :created, location: @custom_domain }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @custom_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_domains/1 or /custom_domains/1.json
  def update
    respond_to do |format|
      if @custom_domain.update(custom_domain_params)
        format.html { redirect_to custom_domain_url(@custom_domain), notice: "Custom domain was successfully updated." }
        format.json { render :show, status: :ok, location: @custom_domain }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @custom_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_domains/1 or /custom_domains/1.json
  def destroy
    if @custom_domain.destroy
      redirect_to settings_organization_path, notice: "Custom domain was successfully destroyed."
    else
      flash[:error] =
        { title: "Cannot delete custom domain",
          body: "This custom domain is actively used in at least one QR code. Deleting this domain would make the QR code unscannable. If you still wish to delete this domain, please first delete any QR codes that are using this domain.", timeout: 60, countdown: true }
      render @custom_domain, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def custom_domain_params
    params.require(:custom_domain).permit(:url)
  end
end
