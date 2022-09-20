# frozen_string_literal: true

json.extract! style, :id, :name, :organization_id, :color, :fill, :created_at, :updated_at
json.url styles_url(style, format: :json)
