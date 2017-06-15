# setup pid file
pids_path =  Rails.root.join('tmp', 'pids')
FileUtils.mkdir_p(pids_path) unless File.directory?(pids_path)

sidekiq_pid_file = File.join(pids_path, 'sidekiq.pid')
File.open(sidekiq_pid_file, 'w'){|f|} unless File.file?(sidekiq_pid_file)

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{REDIS['server']}:#{REDIS['port']}" }
end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://redis.example.com:7372/12' }
# end