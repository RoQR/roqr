# frozen_string_literal: true

module Fly
  class CheckCustomDomainJob < ApplicationJob
    include ActionView::RecordIdentifier
    queue_as :default

    def perform(domain)
      @client = Fly::Client.new
      @domain = domain
      update_status
      update_ips if domain.ipv4_target.nil? || domain.ipv6_target.nil?
      @domain.save!
      refresh_check_button
    end

    private

    def update_status
      cert = @client.check_cert("roqr", @domain.host)
      @domain.status = cert["clientStatus"]
    end

    def update_ips
      ips = @client.get_ips("roqr")
      @domain.assign_attributes(
        ipv4_target: ips.find { |x| x["type"] == "v4" }["address"],
        ipv6_target: ips.find { |x| x["type"] == "v6" }["address"]
      )
    end

    def refresh_check_button
      Turbo::StreamsChannel.broadcast_replace_later_to(
        @domain.organization_id,
        "custom_domains",
        target: "check_button",
        partial: "custom_domains/check_button/default",
        locals: { custom_domain: @domain }
      )
    end
  end
end
