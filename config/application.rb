require_relative "boot"

require "rails/all"

require_relative "../app/middlewares/discoveries_middleware"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module United
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.session_store :active_record_store, key: "_united_session", expire_after: 30.minutes

    config.cache_store = :solid_cache_store
    config.solid_cache.connects_to = {database: {writing: :cache, reading: :cache}}

    config.active_job.queue_adapter = :solid_queue
    config.solid_queue.connects_to = {database: {writing: :queue, reading: :queue}}

    config.mission_control.jobs.base_controller_class = "ActionController::Base"
    
    config.middleware.use DiscoveriesMiddleware
    config.middleware.move_after Warden::Manager, DiscoveriesMiddleware
  end
end
