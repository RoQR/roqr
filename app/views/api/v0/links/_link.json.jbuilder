# frozen_string_literal: true

json.id link.hashid
json.extract!(link, :dynamic, :organization_id, :name, :created_at, :updated_at, :archived_at)
json.data do
  json.id link.link_data.hashid
  json.type link.link_data.class
end
json.url api_v0_link_url(link, format: :json)
