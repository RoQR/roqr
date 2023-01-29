# app/controllers/pages_controller.rb

class PagesController < ApplicationController
  include HighVoltage::StaticPage

  private

  def page_finder_factory
    PageFinder
  end
end
