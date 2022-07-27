require "test_helper"

class PublicPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @public_page = public_pages(:one)
  end

  test "should get index" do
    get public_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_public_page_url
    assert_response :success
  end

  test "should create public_page" do
    assert_difference("PublicPage.count") do
      post public_pages_url, params: { public_page: {  } }
    end

    assert_redirected_to public_page_url(PublicPage.last)
  end

  test "should show public_page" do
    get public_page_url(@public_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_public_page_url(@public_page)
    assert_response :success
  end

  test "should update public_page" do
    patch public_page_url(@public_page), params: { public_page: {  } }
    assert_redirected_to public_page_url(@public_page)
  end

  test "should destroy public_page" do
    assert_difference("PublicPage.count", -1) do
      delete public_page_url(@public_page)
    end

    assert_redirected_to public_pages_url
  end
end
