# frozen_string_literal: true

json.array! @styles, partial: 'api/v0/styles/style', as: :style
