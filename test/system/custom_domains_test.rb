require "application_system_test_case"

class CustomDomainsTest < ApplicationSystemTestCase
  setup do
    @custom_domain = custom_domains(:one)
  end

  test "visiting the index" do
    visit custom_domains_url
    assert_selector "h1", text: "Custom domains"
  end

  test "should create custom domain" do
    visit custom_domains_url
    click_on "New custom domain"

    click_on "Create Custom domain"

    assert_text "Custom domain was successfully created"
    click_on "Back"
  end

  test "should update Custom domain" do
    visit custom_domain_url(@custom_domain)
    click_on "Edit this custom domain", match: :first

    click_on "Update Custom domain"

    assert_text "Custom domain was successfully updated"
    click_on "Back"
  end

  test "should destroy Custom domain" do
    visit custom_domain_url(@custom_domain)
    click_on "Destroy this custom domain", match: :first

    assert_text "Custom domain was successfully destroyed"
  end
end
