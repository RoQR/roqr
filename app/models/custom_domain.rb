class CustomDomain < ApplicationRecord
  belongs_to :organization
  has_many :links, dependent: :restrict_with_error
  after_create_commit do
    Fly::CreateCustomDomainJob.perform_later(self)
  end
  after_update_commit -> { broadcast_replace_later_to organization_id, :custom_domains }
  after_destroy_commit do
    Fly::DeleteCustomDomainJob.perform_later(host)
  end

  def host
    URI.parse(url).host
  end

  def trd
    PublicSuffix.parse(host).trd
  end
end
