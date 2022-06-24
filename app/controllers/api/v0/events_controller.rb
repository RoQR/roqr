class Api::V0::EventsController < Api::V0::BaseController
  load_and_authorize_resource

  def index
    current_user.requests.create(method: :get, requestable_type: 'Event')
  end
end
