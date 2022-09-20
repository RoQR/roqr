# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'account@m.roqr.app'
  layout 'mailer'
end
