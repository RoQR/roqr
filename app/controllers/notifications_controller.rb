# frozen_string_literal: true

class NotificationsController < ApplicationController
  load_and_authorize_resource
  def index
    @notifications.unread.each(&:mark_as_read!)
  end
end
