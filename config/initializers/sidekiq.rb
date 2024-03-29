# require "sidekiq-scheduler"



# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://127.0.0.1:6379/0' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://127.0.0.1:6379/0' }
# end
# # Sidekiq.configure_server do |config|
# #   config.redis = { url: 'redis://redis:6379/0' }
# # end

# # Sidekiq.configure_client do |config|
# #   config.redis = { url: 'redis://redis:6379/0' }
# # end


redis_url = ENV['REDIS_URL'] || 'redis://127.0.0.1:6379/0'

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
