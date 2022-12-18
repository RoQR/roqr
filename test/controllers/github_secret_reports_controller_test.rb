require "test_helper"

class GithubSecretReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @token = @user.private_api_key
    @keypair = OpenSSL::PKey::EC.generate("prime256v1")
    stub_request(:get, "https://api.github.com/meta/public_keys/secret_scanning")
      .to_return(status: 200, body: {
        public_keys: [{
          key_identifier: key_id,
          key: @keypair.to_pem,
          is_current: true
        }]
      }.to_json)
  end

  test "can report actual leaked token" do
    post github_secret_reports_url, as: :json, headers:, params: {
      github_secret_report: {
        _json: payload
      }
    }
    assert_response :success
    assert_equal JSON.parse(response.body).first["label"], "true_positive"
  end

  test "can get false_positive for bad token" do
    @token = "roqr_test"
    post github_secret_reports_url, as: :json, headers:, params: {
      github_secret_report: {
        _json: payload
      }
    }
    assert_response :success
    assert_equal JSON.parse(response.body).first["label"], "false_positive"
  end

  test "gets error with mismatching signature" do
    post github_secret_reports_url, as: :json, headers: {
      'GITHUB-PUBLIC-KEY-IDENTIFIER': key_id,
      'GITHUB-PUBLIC-KEY-SIGNATURE': "MEUCIFLZzeK++IhS+y276SRk2Pe5LfDrfvTXu6iwKKcFGCrvAiEAhHN2kDOhy2I6eGkOFmxNkOJ+L2y8oQ9A2T9GGJo6WJY="
    }, params: {
      github_secret_report: {
        _json: payload
      }
    }
    assert_response :unauthorized
  end

  private

  def headers
    {
      'GITHUB-PUBLIC-KEY-IDENTIFIER': key_id,
      'GITHUB-PUBLIC-KEY-SIGNATURE': signature
    }
  end

  def key_id
    @keypair.public_key.to_bn.to_s(16).downcase
  end

  def signature
    digest = OpenSSL::Digest.new("SHA256")
    Base64.encode64(@keypair.sign(digest, payload.to_json))
  end

  def payload
    [{ token: @token, type: "roqr_api_key", url: "https://example.com", source: "commit" }]
  end
end
