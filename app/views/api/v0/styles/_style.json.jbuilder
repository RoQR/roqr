json.extract! style, :id, :name, :organization_id, :dots_color, :dots_shape, :background_color, :corner_squares_color,
              :corner_squares_shape, :corner_dots_color, :corner_dots_shape, :created_at, :updated_at
json.url api_v0_styles_url(style, format: :json)
