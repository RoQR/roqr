require "test_helper"

class CustomDomainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @custom_domain = custom_domains(:one)
  end

  test "should get index" do
    get custom_domains_url
    assert_response :success
  end

  test "should get new" do
    get new_custom_domain_url
    assert_response :success
  end

  test "should create custom_domain" do
    assert_difference("CustomDomain.count") do
      post custom_domains_url, params: { custom_domain: {  } }
    end

    assert_redirected_to custom_domain_url(CustomDomain.last)
  end

  test "should show custom_domain" do
    get custom_domain_url(@custom_domain)
    assert_response :success
  end

  test "should get edit" do
    get edit_custom_domain_url(@custom_domain)
    assert_response :success
  end

  test "should update custom_domain" do
    patch custom_domain_url(@custom_domain), params: { custom_domain: {  } }
    assert_redirected_to custom_domain_url(@custom_domain)
  end

  test "should destroy custom_domain" do
    assert_difference("CustomDomain.count", -1) do
      delete custom_domain_url(@custom_domain)
    end

    assert_redirected_to custom_domains_url
  end
end
