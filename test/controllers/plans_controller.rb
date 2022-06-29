require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @user = create(:user, organization: @org)
    sign_in @user
    @user.confirm
  end

  test 'should not load without feature flag' do
    get plans_url
    assert_response :not_found
  end

  test 'should load with feature flag' do
    Flipper.enable :stripe, @user
    get plans_url
    assert_response :success
  end
end
