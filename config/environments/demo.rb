Rails.application.configure do
  ENV["DEMO_MODE"] = 1.to_s

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true
  config.assets.compile = false
  config.assets.unknown_asset_fallback = false
  config.assets.digest = true
  config.assume_ssl = true
  config.force_ssl = true
  config.action_dispatch.show_exceptions = false

  # Recommended development/test-like behaviors:
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries = false

  config.eager_load = false

  config.active_storage.service = :local

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true
end
