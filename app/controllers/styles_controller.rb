class StylesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource only: :show

  # GET /styles or /styles.json
  def index; end

  # GET /styles/1 or /styles/1.json
  def show
    respond_to do |format|
      format.html do
        authenticate_user!
        authorize! :show, @style
        render :show
      end
      format.json do
      end
    end
  end

  # GET /styles/new
  def new
    add_breadcrumb 'All styles', styles_path
    add_breadcrumb 'New style', new_style_path
  end

  # GET /styles/1/edit
  def edit
    add_breadcrumb 'All styles', styles_path
    add_breadcrumb @style.name, edit_style_path(@style)
  end

  # POST /styles or /styles.json
  def create
    respond_to do |format|
      if @style.save
        format.html { redirect_to styles_url, notice: 'Style was successfully created.' }
        format.json { render :show, status: :created, location: @style }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /styles/1 or /styles/1.json
  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to styles_url, notice: 'Style was successfully updated.' }
        format.json { render :show, status: :ok, location: @style }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1 or /styles/1.json
  def destroy
    @style.destroy

    respond_to do |format|
      format.html { redirect_to styles_url, notice: 'Style was successfully destroyed.' }
      format.turbo_stream
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def style_params
    params.require(:style).permit(:name, :organization_id, :color, :fill, :position_border_color, :position_core_color)
  end
end
