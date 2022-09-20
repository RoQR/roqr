# frozen_string_literal: true

require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @user = create(:user, organization: @org)
    @organization = @user.organization
    sign_in @user
    @user.confirm
  end

  test 'should update organization' do
    patch organization_url(@organization),
          params: { organization: { name: @organization.name } }
    assert_redirected_to settings_organization_url
  end
end
