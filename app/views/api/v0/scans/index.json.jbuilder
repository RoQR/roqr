# frozen_string_literal: true

json.array! @scans, partial: 'api/v0/scans/scan', as: :scan
