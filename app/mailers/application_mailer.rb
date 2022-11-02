# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "RoQR <account@m.roqr.app>"
  layout "mailer"
end
