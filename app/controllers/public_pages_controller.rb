# frozen_string_literal: true

class PublicPagesController < ApplicationController
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource

  # GET /public_pages
  def index; end

  # GET /public_pages/1
  def show
    @all_scans = @public_page.scans
    @scans = @all_scans.page params[:page]
    render layout: 'public_page'
  end

  # GET /public_pages/new
  def new; end

  # GET /public_pages/1/edit
  def edit; end

  # POST /public_pages
  def create
    respond_to do |format|
      if @public_page.save
        format.html { redirect_to public_page_url(@public_page), notice: 'Public page was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_pages/1
  def update
    respond_to do |format|
      if @public_page.update(public_page_params)
        format.html { redirect_to public_page_url(@public_page), notice: 'Public page was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_pages/1
  def destroy
    @public_page.destroy
    respond_to do |format|
      format.html { redirect_to public_pages_url, notice: 'Public page was successfully destroyed.' }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def public_page_params
    params.require(:public_page).permit(:name)
  end
end
