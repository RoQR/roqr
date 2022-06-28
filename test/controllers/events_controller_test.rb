require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @user.confirm
    sign_in @user
  end

  test 'should get index when logged in' do
    get events_url
    assert_response :success
  end
end
