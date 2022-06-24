require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @org = create(:organization)
    @user = create(:user, organization: @org)
    sign_in @user
    @user.confirm
    @link = create(:link, :url, organization: @org)
  end

  test 'should get index' do
    get links_url
    assert_response :success
  end

  test 'should get new' do
    get new_link_url
    assert_response :success
  end

  test 'should create link' do
    @link = build(:link, :url)
    assert_difference('Link.count') do
      post links_url, params: { link: { name: @link.name, url_link_attributes: { url: @link.url_link } } }
    end

    assert_redirected_to links_url
  end

  test 'should show link' do
    get link_url(@link)
    assert_response :success
  end

  test 'should get edit' do
    get edit_link_url(@link)
    assert_response :success
  end

  test 'should scan link' do
    get scan_link_url(@link)
    assert_redirected_to @link.link_data.url
  end

  test 'should update link' do
    patch link_url(@link),
          params: { link: { id: @link.id, name: @link.name, url_link_attributes: { url: @link.url_link } } }
    assert_redirected_to link_url(@link)
  end

  test 'should destroy link' do
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
