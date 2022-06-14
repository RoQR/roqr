require "test_helper"

class UrlLinksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get url_links_new_url
    assert_response :success
  end

  test "should get show" do
    get url_links_show_url
    assert_response :success
  end

  test "should get edit" do
    get url_links_edit_url
    assert_response :success
  end

  test "should get create" do
    get url_links_create_url
    assert_response :success
  end

  test "should get update" do
    get url_links_update_url
    assert_response :success
  end

  test "should get destroy" do
    get url_links_destroy_url
    assert_response :success
  end
end
