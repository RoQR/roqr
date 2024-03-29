# frozen_string_literal: true

json.extract! style, :id, :name, :organization_id, :dots_color, :dots_shape, :transparent_background, :background_color, :corner_squares_color,
              :corner_squares_shape, :corner_dots_color, :corner_dots_shape, :image_url, :created_at, :updated_at
json.url api_v1_styles_url(style, format: :json)
