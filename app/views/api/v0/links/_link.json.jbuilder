# frozen_string_literal: true

json.extract! link, :id, :user_id, :name, :created_at, :updated_at, :link_data
json.url api_v0_link_url(link, format: :json)
