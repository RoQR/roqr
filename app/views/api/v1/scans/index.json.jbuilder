# frozen_string_literal: true

json.array! @scans, partial: "api/v1/scans/scan", as: :scan
