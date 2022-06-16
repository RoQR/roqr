module LinkDataConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    load_resource :links
    load_and_authorize_resource instance_name: :link_data

    # GET /links/1 or /links/1.json
    def show
      add_breadcrumb "All links", links_path
      add_breadcrumb @link_data.links.name, @link_data 
    end

    # GET /links/new
    def new
      add_breadcrumb "All links", links_path
      add_breadcrumb "New link", new_link_path
      @link_data.links.build
    end

    # GET /links/1/edit
    def edit
      add_breadcrumb "All links", links_path
      add_breadcrumb "Edit", edit_link_path(@link_data)
    end

    # POST /links or /links.json
    def create
      respond_to do |format|
        if @link_data.save
          format.html { redirect_to links_url, success: "Link was successfully created." }
          format.json { render :show, status: :created, location: @link_data }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @link_data.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /links/1 or /links/1.json
    def update
      respond_to do |format|
        if @link_data.update(link_data_params)
          format.html { redirect_to links_url, success: "Link was successfully updated." }
          format.json { render :show, status: :ok, location: @link_data }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @link_data.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /links/1 or /links/1.json
    def destroy
      @link_data.destroy

      respond_to do |format|
        format.html { redirect_to links_url, success: "Link was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end
end
