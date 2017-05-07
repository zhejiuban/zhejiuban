require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Zhejiuban
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = 'Beijing'
    config.load_defaults 5.1
    config.middleware.use Rack::Attack

    # Ensure App config files exist.
    if Rails.env.development?
      %w(app redis secrets).each do |fname|
        filename = "config/#{fname}.yml"
        next if File.exist?(Rails.root.join(filename))
        FileUtils.cp(Rails.root.join("#{filename}.default"), Rails.root.join(filename))
      end
    end

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'models', '*.yml').to_s]
    config.i18n.default_locale = 'zh-CN'
    config.i18n.available_locales = ['zh-CN', 'en']

    redis_config = Rails.application.config_for(:redis)
    config.cache_store = :redis_store, {
      servers: [
        {
          host: redis_config['host'],
          port: redis_config['port'],
          db: 0,
          namespace: "cache"
        },
      ]
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
