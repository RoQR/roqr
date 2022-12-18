class GithubSecretReportsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :validate_signature

  def create
    token = github_secret_report_params.first[:token]
    user = User.find_by_private_api_key(token)
    if user
      user.rotate_api_key!
      CompromisedTokenNotification.with(url: github_secret_report_params.first[:url]).deliver_later(user)
      label = "true_positive"
    else
      label = "false_positive"
    end
    render json: [{ token_raw: token, token_type: "roqr_api_token", label: }]
  end

  private

  def github_secret_report_params
    params.require("github_secret_report").require("_json")
  end

  def request_github_keys
    raise "Need to define GITHUB_PRODUCTION_TOKEN environment variable" unless ENV["GITHUB_PRODUCTION_TOKEN"]

    HTTParty.get(
      "https://api.github.com/meta/public_keys/secret_scanning",
      {
        headers: {
          Authorization: "Bearer #{ENV.fetch('GITHUB_PRODUCTION_TOKEN', nil)}"
        }
      }
    )
  end

  def github_key
    github_response = request_github_keys
    parsed_response = JSON.parse(github_response.body)
    current_key_object = parsed_response["public_keys"].find { |key| key["key_identifier"] == key_id }
    current_key = current_key_object["key"]
    OpenSSL::PKey::EC.new(current_key)
  end

  def payload
    github_secret_report_params.to_json
  end

  def key_id
    request.headers["GITHUB-PUBLIC-KEY-IDENTIFIER"]
  end

  def signature
    request.headers["GITHUB-PUBLIC-KEY-SIGNATURE"]
  end

  def validate_signature
    return if github_key.verify(OpenSSL::Digest.new("SHA256"), Base64.decode64(signature), payload.chomp)

    head :unauthorized
  end
end
