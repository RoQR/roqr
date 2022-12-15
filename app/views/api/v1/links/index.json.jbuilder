# frozen_string_literal: true

json.array! @links, partial: "api/v1/links/link", as: :link
