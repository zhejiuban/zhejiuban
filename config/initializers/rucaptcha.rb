# memcached_config = Rails.application.config_for(:memcached)
redis_config = Rails.application.config_for(:redis)
RuCaptcha.configure do
  # self.cache_store = [:mem_cache_store, memcached_config['host'], memcached_config]
  self.cache_store = :redis_store, {
    servers: [
      {
        host: redis_config['host'],
        port: redis_config['port'],
        db: 0,
        namespace: "recaptcha"
      },
    ]
  }
end
