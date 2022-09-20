# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://fbb1f70d628842af87504b368db90218@o1295260.ingest.sentry.io/6520504'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.enabled_environments = %w[production]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
