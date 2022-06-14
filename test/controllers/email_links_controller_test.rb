require "test_helper"

class EmailLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_link = email_links(:one)
  end

  test "should get index" do
    get email_links_url
    assert_response :success
  end

  test "should get new" do
    get new_email_link_url
    assert_response :success
  end

  test "should create email_link" do
    assert_difference("EmailLink.count") do
      post email_links_url, params: { email_link: { email: @email_link.email } }
    end

    assert_redirected_to email_link_url(EmailLink.last)
  end

  test "should show email_link" do
    get email_link_url(@email_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_link_url(@email_link)
    assert_response :success
  end

  test "should update email_link" do
    patch email_link_url(@email_link), params: { email_link: { email: @email_link.email } }
    assert_redirected_to email_link_url(@email_link)
  end

  test "should destroy email_link" do
    assert_difference("EmailLink.count", -1) do
      delete email_link_url(@email_link)
    end

    assert_redirected_to email_links_url
  end
end
