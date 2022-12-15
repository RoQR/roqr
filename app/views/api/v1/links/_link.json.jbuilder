# frozen_string_literal: true

json.id link.hashid
json.organization_id link.organization.hashid
json.extract!(link, :name, :dynamic, :created_at, :updated_at, :archived_at)
json.custom_domain link.custom_domain&.url
json.type link.link_type.chomp("_link")
json.data do
  json.partial! "api/v1/links/#{link.link_type}", link_data: link.link_data, as: :link_data
end
json.url api_v1_link_url(link, format: :json)
