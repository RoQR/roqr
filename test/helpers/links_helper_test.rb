# frozen_string_literal: true

require "test_helper"

class LinksHelperTest < ActiveSupport::TestCase
  include LinksHelper
  include Rails.application.routes.url_helpers

  test "should generate dynamic link" do
    @link = create(:link, :url, dynamic: true)
    assert_equal barcode_data(@link), scan_link_url(@link)
  end

  test "should generate static link" do
    @link = create(:link, :url, dynamic: false)
    assert_equal barcode_data(@link), @link.link_data.url
  end

  test "should embed custom domain in barcode" do
    custom_domain = create(:custom_domain)
    @link = create(:link, :url, custom_domain:, organization: custom_domain.organization, dynamic: true)
    assert_equal barcode_data(@link), custom_domain.url + scan_link_path(@link)
  end
end
