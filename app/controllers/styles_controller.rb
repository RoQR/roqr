# frozen_string_literal: true

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
    render TurboModalComponent.new(title: 'New style').with_content(render_to_string(partial: 'styles/form',
                                                                                     locals: { style: @style }))
  end

  # GET /styles/1/edit
  def edit
    render TurboModalComponent.new(title: 'Edit style').with_content(render_to_string(partial: 'styles/form',
                                                                                      locals: { style: @style }))
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
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
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
    params.require(:style).permit(
      :name, :organization_id, :dots_color, :dots_shape, :background_color, :corner_dots_color,
      :corner_dots_shape, :corner_squares_color, :corner_squares_shape, :image_url
    )
  end
end
