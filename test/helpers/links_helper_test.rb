require 'test_helper'

class LinksHelperTest < ActiveSupport::TestCase
  include LinksHelper
  include Rails.application.routes.url_helpers

  test 'should generate dynamic link' do
    @link = create(:link, :url, dynamic: true)
    assert_equal barcode_data(@link), scan_link_url(@link)
  end

  test 'should generate static link' do
    @link = create(:link, :url, dynamic: false)
    assert_equal barcode_data(@link), @link.link_data.url
  end
end
