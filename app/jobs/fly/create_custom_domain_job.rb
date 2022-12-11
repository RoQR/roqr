# frozen_string_literal: true

module Fly
  class CreateCustomDomainJob < ApplicationJob
    queue_as :default

    def perform(domain)
      client = Fly::Client.new
      cert = client.add_cert("roqr", domain.host)
      domain.update!(
        dns_validation_target: cert["dnsValidationTarget"],
        dns_validation_hostname: PublicSuffix.parse(cert["dnsValidationHostname"]).trd,
        status: "Awaiting configuration"
      )
    end
  end
end
