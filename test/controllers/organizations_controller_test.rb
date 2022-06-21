require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get organizations_update_url
    assert_response :success
  end
end
