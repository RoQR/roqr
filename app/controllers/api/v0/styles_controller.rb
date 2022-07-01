class Api::V0::StylesController < Api::V0::BaseController
  load_and_authorize_resource

  def index
    current_user.requests.create(method: :get, requestable_type: 'Style')
  end

  def show
    current_user.requests.create(method: :get, requestable_type: 'Style')
  end
end
