# frozen_string_literal: true

class StylesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource only: :show

  # GET /styles
  def index
    @styles = @styles.includes(:organization)
  end

  # GET /styles/1
  def show
    respond_to do |format|
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

  # POST /styles
  def create
    if truthy?(@style.transparent_background)
      @style.background_color = 'transparent'
    end
    respond_to do |format|
      if @style.save
        format.html { redirect_to styles_url, notice: 'Style was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /styles/1
  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to styles_url, notice: 'Style was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1
  def destroy
    @style.destroy

    respond_to do |format|
      format.html { redirect_to styles_url, notice: 'Style was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def style_params
    params.require(:style).permit(
      :name, :dots_color, :dots_shape, :background_color, :transparent_background, :corner_dots_color,
      :corner_dots_copy_dots, :corner_dots_shape, :corner_squares_color, :corner_squares_shape,
      :corner_squares_copy_dots, :image_url
    )
  end
end
