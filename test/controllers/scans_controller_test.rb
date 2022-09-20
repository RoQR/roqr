# frozen_string_literal: true

require 'test_helper'

class ScansControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @user.confirm
    sign_in @user
  end

  test 'should load' do
    get scans_url
    assert_response :success
  end
end
