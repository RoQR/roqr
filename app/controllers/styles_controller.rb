class StylesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource only: :show

  # GET /styles or /styles.json
  def index; end

  # GET /styles/1 or /styles/1.json
  def show
    respond_to do |format|
      format.svg do
        @params = params.permit(:id, :format, :fill, :color)
        render inline: QrGenerator.gen('https://roqr.app', fill: params[:fill] || @style.fill,
                                                           color: params[:color] || @style.color)
      end

      format.html do
        authenticate_user!
        authorize! :show, @style
        render :show
      end
    end
  end

  # GET /styles/new
  def new; end

  # GET /styles/1/edit
  def edit; end

  # POST /styles or /styles.json
  def create
    respond_to do |format|
      if @style.save
        format.html { redirect_to styles_url, notice: 'Style was successfully created.' }
        format.json { render :show, status: :created, location: @style }
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
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def style_params
    params.require(:style).permit(:name, :organization_id, :color, :fill)
  end
end
