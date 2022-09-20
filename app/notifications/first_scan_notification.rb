# frozen_string_literal: true

class FirstScanNotification < Noticed::Base
  include ActionView::Helpers::UrlHelper
  deliver_by :database

  param :link_name

  def message
    link_to "#{params[:link_name]} got its first scan! View insights", scans_path
  end
end
