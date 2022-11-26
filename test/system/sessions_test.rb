require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  def setup
    @user = create(:user)
  end

  test "can log in" do
    visit new_user_session_path
    assert_selector "h2", text: "Sign in to your account"

    log_in

    assert_text "Signed in successfully"
  end

  test "cannot log in if unconfirmed" do
    @user = create(:user, :unconfirmed)
    visit new_user_session_path
    log_in
    assert_text "You have to confirm your email address before continuing"
  end

  private

  def log_in
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Sign in"
  end
end
