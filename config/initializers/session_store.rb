# Be sure to restart your server when you modify this file.
# Rails.application.config.session_store :cookie_store, key: '_homeland_session', expire_after: 86400*90
redis_config = Rails.application.config_for(:redis)
Rails.application.config.session_store :redis_store, {
  servers: [
    {
      host: redis_config['host'],
      port: redis_config['port'],
      db: 0,
      namespace: "session"
    },
  ],
  expire_after: 90.minutes
}
