class EmailLinksController < ApplicationController
  before_action :authenticate_user!
  load_resource :links
  load_and_authorize_resource

  # GET /links/1 or /links/1.json
  def show
    add_breadcrumb "All links", links_path
    add_breadcrumb @email_link.link.name, @email_link 
  end

  # GET /links/new
  def new
    add_breadcrumb "All links", links_path
    add_breadcrumb "New link", new_email_link_path
    @email_link.links.build
  end

  # GET /links/1/edit
  def edit
    add_breadcrumb "All links", links_path
    add_breadcrumb "Edit", edit_link_path(@email_link)
  end

  # POST /links or /links.json
  def create
    respond_to do |format|
      if @email_link.save
        format.html { redirect_to links_url, success: "Link was successfully created." }
        format.json { render :show, status: :created, location: @email_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @email_link.update(email_link_params)
        format.html { redirect_to links_url, success: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @email_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @email_link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, success: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def email_link_params
      params.require(:email_link).permit(:id, :email_address, :subject, :body, links_attributes: [:id, :user_id, :name])
    end
end
