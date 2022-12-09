# frozen_string_literal: true

module Fly
  class DeleteCustomDomainJob < ApplicationJob
    queue_as :default

    def perform(url)
      client = Fly::Client.new
      client.delete_cert("roqr", url)
    end
  end
end
