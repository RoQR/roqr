json.extract! event, :id, :link_id, :ip, :browser_name, :browser_version, :bot_name, :device_name, :platform_name, :platform_version, :language, :city, :country, :created_at, :updated_at
json.url api_v0_events_url(event, format: :json)
