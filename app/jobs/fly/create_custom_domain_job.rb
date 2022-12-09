# frozen_string_literal: true

module Fly
  class CreateCustomDomainJob < ApplicationJob
    queue_as :default

    def perform(domain)
      client = Fly::Client.new
      cert = client.add_cert("roqr", domain.url)
      domain.update!(
        dns_validation_target: cert["dnsValidationTarget"],
        dns_validation_hostname: cert["dnsValidationHostname"],
        status: "Awaiting configuration"
      )
    end
  end
end
