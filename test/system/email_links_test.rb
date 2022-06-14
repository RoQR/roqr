require "application_system_test_case"

class EmailLinksTest < ApplicationSystemTestCase
  setup do
    @email_link = email_links(:one)
  end

  test "visiting the index" do
    visit email_links_url
    assert_selector "h1", text: "Email links"
  end

  test "should create email link" do
    visit email_links_url
    click_on "New email link"

    fill_in "Email", with: @email_link.email
    click_on "Create Email link"

    assert_text "Email link was successfully created"
    click_on "Back"
  end

  test "should update Email link" do
    visit email_link_url(@email_link)
    click_on "Edit this email link", match: :first

    fill_in "Email", with: @email_link.email
    click_on "Update Email link"

    assert_text "Email link was successfully updated"
    click_on "Back"
  end

  test "should destroy Email link" do
    visit email_link_url(@email_link)
    click_on "Destroy this email link", match: :first

    assert_text "Email link was successfully destroyed"
  end
end
