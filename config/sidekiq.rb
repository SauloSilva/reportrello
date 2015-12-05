require 'rubygems'
require 'bundler'
require 'pathname'
Bundler.require
require 'sinatra/base'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'
require 'trello'
require 'uri'

uri = ENV['REDIS_URL'] || 'redis://127.0.0.1:6379/0'
redis_server_size = ENV['REDIS_CONFIGURE_SERVER_SIZE'].to_i || 5

Sidekiq.configure_server do |config|
  config.redis = { size: redis_server_size, url: uri }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 1, url: uri }
end

SIDEKIQ_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# Load the models
Dir[SIDEKIQ_ROOT + 'app/models/**/*.rb'].each { |file| require file }

# Load the services
Dir[SIDEKIQ_ROOT + 'app/services/**/*.rb'].each { |file| require file }

# Load the workers
Dir[SIDEKIQ_ROOT + 'app/workers/**/*.rb'].each { |file| require file }

get '/sidekiq/stats' do
  stats = Sidekiq::Stats.new
  workers = Sidekiq::Workers.new

  "
    <p>Processed: #{stats.processed}</p>
    <p>In Progress: #{workers.size}</p>
    <p>Enqueued: #{stats.enqueued}</p>
    <p><a href='/'>Refresh</a></p>
    <p><a href='/add_job'>Add Job</a></p>
    <p><a href='/sidekiq'>Dashboard</a></p>
  "
end