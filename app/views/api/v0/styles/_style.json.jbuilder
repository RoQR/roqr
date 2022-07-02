json.extract! style, :id, :name, :organization_id, :color, :fill, :position_border_color, :position_core_color,
              :created_at, :updated_at
json.url api_v0_styles_url(style, format: :json)
