json.extract! user, :id, :name, :can_create_links, :created_at, :updated_at
json.url user_url(user, format: :json)
