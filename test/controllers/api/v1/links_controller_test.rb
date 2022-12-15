# frozen_string_literal: true

require "test_helper"

module Api
  module V1
    class LinksControllerTest < ActionDispatch::IntegrationTest
      setup do
        @org = create(:organization)
        @user = create(:user, organization: @org)
        @user.confirm
        @link = create(:link, :url, organization: @org)
      end

      test "should get index" do
        get api_v1_links_url, headers: headers
        assert_response :success
      end

      test "should get show" do
        get api_v1_link_url(@link), headers: headers
        assert_response :success
      end

      test "should create" do
        assert_difference(["Link.count", "UrlLink.count"]) do
          post api_v1_links_url, headers:, params: create_link_params
        end
        assert_response :created
      end

      test "should update" do
        patch api_v1_link_url(@link), headers:, params: update_link_params
        assert_response :success
      end

      test "should archive" do
        post archive_api_v1_link_url(@link), headers: headers
        assert_response :success
      end

      test "should unarchive" do
        @link.archive!
        post unarchive_api_v1_link_url(@link), headers: headers
        assert_response :success
      end

      test "should delete" do
        @link.archive!
        delete api_v1_link_url(@link), headers: headers
        assert_response :success
      end

      private

      def create_link_params
        {
          name: "New link",
          dynamic: true,
          data: {
            type: "url",
            url: "https://roqr.app"
          }
        }
      end

      def update_link_params
        {
          name: "New name",
          data: {
            url: "https://new.app"
          }
        }
      end

      def headers
        { HTTP_AUTHORIZATION: api_key }
      end

      def api_key
        "Bearer #{@user.private_api_key}"
      end
    end
  end
end
