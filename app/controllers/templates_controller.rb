class TemplatesController < ApplicationController
  before_action :authenticate_user!
  skip_authorize_resource only: :show

  # GET /templates or /templates.json
  def index
    @templates = Template.accessible_by(current_ability)
  end

  # GET /templates/1 or /templates/1.json
  def show
    @template = Template.find_by(params[:id])
    respond_to do |format|
      format.svg do
        @params = params.permit(:id, :format, :fill, :color)
        render inline: QrGenerator.gen('https://roqr.app', fill: params[:fill] || @template.fill,
                                                           color: params[:color] || @template.color)
      end

      format.html do
        authenticate_user!
        authorize! :show, @template
        render :show
      end
    end
  end

  # GET /templates/new
  def new
    @template = current_user.organization.template.new
  end

  # GET /templates/1/edit
  def edit; end

  # POST /templates or /templates.json
  def create
    @template = Template
    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_url, notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1 or /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to templates_url, notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1 or /templates/1.json
  def destroy
    @template.destroy

    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def template_params
    params.require(:template).permit(:name, :organization_id, :color, :fill)
  end
end
