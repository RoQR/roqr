require "test_helper"

class MarketingControllerTest < ActionDispatch::IntegrationTest

  test "should_load" do
    get marketing_url
    assert_response :success
  end
end
