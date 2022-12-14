# frozen_string_literal: true

require "test_helper"

module Api
  module V0
    class LinksControllerTest < ActionDispatch::IntegrationTest
      setup do
        @org = create(:organization)
        @user = create(:user, organization: @org)
        @user.confirm
        @link = create(:link, :url, organization: @org)
      end

      test "should get index" do
        get api_v0_links_url, headers: { HTTP_AUTHORIZATION: api_key }
        assert_response :success
      end

      test "should create" do
        assert_difference(["Link.count", "UrlLink.count"]) do
          post api_v0_links_url, headers: { HTTP_AUTHORIZATION: api_key },
                                 params: { link: {
                                   name: "New link",
                                   dynamic: true,
                                   url_link_attributes: {
                                     url: "https://roqr.app"
                                   }
                                 } }
        end
        assert_response :success
      end

      private

      def api_key
        "Bearer #{@user.private_api_key}"
      end
    end
  end
end
