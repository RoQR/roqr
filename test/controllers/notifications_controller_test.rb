# frozen_string_literal: true

require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @user = create(:user)
    sign_in @user
    @user.confirm
  end

  test 'should get index' do
    get notifications_index_url
    assert_response :success
  end
end
