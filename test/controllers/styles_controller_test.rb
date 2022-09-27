# frozen_string_literal: true

require 'test_helper'

class StylesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @user = create(:user)
    @user.confirm
    sign_in @user
    @style = create(:style, organization: @user.organization)
  end

  test 'should get index' do
    get styles_url
    assert_response :success
  end

  test 'should get new' do
    get new_style_url
    assert_response :success
  end

  test 'should create style' do
    assert_difference('Style.count') do
      post styles_url,
           params: {
             style: {
               dots_color: @style.dots_color,
               background_color: @style.background_color,
               name: "#{@style.name} new"
             }
           }
    end

    assert_redirected_to styles_url
  end

  test 'should get edit' do
    get edit_style_url(@style)
    assert_response :success
  end

  test 'should update style' do
    patch style_url(@style),
          params: {
            style: {
              dots_color: @style.dots_color,
              background_color: @style.background_color,
              name: @style.name
            }
          }
    assert_redirected_to styles_url
  end

  test 'should destroy style' do
    assert_difference('Style.count', -1) do
      delete style_url(@style)
    end

    assert_redirected_to styles_url
  end
end
