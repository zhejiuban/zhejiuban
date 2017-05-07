redis_config = Rails.application.config_for(:redis)
Rails.application.config.cache_store = :redis_store, {
  servers: [
    {
      host: redis_config['host'],
      port: redis_config['port'],
      db: 0,
      namespace: "cache"
    },
  ]
}
