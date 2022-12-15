# frozen_string_literal: true

json.array! @styles, partial: "api/v1/styles/style", as: :style
