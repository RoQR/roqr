require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @user.confirm
    sign_in @user
  end

  test 'should load profile' do
    get settings_profile_url
    assert_response :success
  end

  test 'should load organization' do
    get settings_organization_url
    assert_response :success
  end

  test 'should load developer' do
    get settings_developer_url
    assert_response :success
  end
end
