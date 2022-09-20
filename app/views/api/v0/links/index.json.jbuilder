# frozen_string_literal: true

json.array! @links, partial: 'api/v0/links/link', as: :link
