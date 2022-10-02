# frozen_string_literal: true

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

  test 'should show link' do
    get link_url(@link)
    assert_response :success
  end

  test 'should scan link' do
    assert_difference('Scan.count') do
      get scan_link_url(@link)
    end
    assert_redirected_to @link.link_data.url
  end

  test 'should scan link that sends data' do
    contact_link = create(:link, :contact, organization: @org)
    assert_difference('Scan.count') do
      get scan_link_url(contact_link)
    end
    assert response.header['Content-Type'], 'text/vcard'
  end

  test 'should authenticate on link with password' do
    @link = create(:link, :url, dynamic: true, password: 'pass')
    get scan_link_url(@link)
    assert_response :unauthorized
    assert_equal "Basic realm=\"link-#{@link.hashid}\"", response.header['WWW-Authenticate']
  end

  test 'should redirect on link with correct password' do
    @link = create(:link, :url, dynamic: true, password: 'pass')
    get scan_link_url(@link), params: nil, headers: {
      HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials('', 'pass')
    }
    assert_redirected_to @link.link_data.url
  end

  test 'should get new' do
    get new_link_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_link_url(@link)
    assert_response :success
  end

  test 'should create link' do
    link = build(:link, :url)
    assert_difference('Link.count') do
      assert_difference('UrlLink.count') do
        post links_url, params: { link: { name: link.name, url_link_attributes: { url: link.url_link } } }
      end
    end

    assert_redirected_to Link.find_by_name(link.name)
  end

  test 'should update link' do
    patch link_url(@link),
          params: { link: { id: @link.id, name: @link.name, url_link_attributes: { url: @link.url_link } } }
    assert_redirected_to link_url(@link)
  end

  test 'should remove password' do
    link_with_password = create(:link, :url, dynamic: true, password: 'test', organization: @org)
    patch remove_password_link_url(link_with_password)
    assert_response :success
    link_with_password.reload
    assert_nil link_with_password.password_digest
  end

  test 'should archive link' do
    assert_difference('Link.active.count', -1) do
      assert_difference('Link.archived.count', 1) do
        get archive_link_url(@link)
      end
    end

    assert_redirected_to links_url
  end

  test 'should confirm destroy link' do
    get archive_link_url(@link)
    get confirm_destroy_link_url(@link)
    assert_response :success
  end

  test 'should destroy link' do
    get archive_link_url(@link)
    assert_difference('Link.count', -1) do
      assert_difference('UrlLink.count', -1) do
        delete link_url(@link)
      end
    end

    assert_redirected_to links_url
  end
end
