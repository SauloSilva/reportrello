web: bundle exec rackup config.ru -p $PORT
worker: bundle exec sidekiq -r ./config/sidekiq.rb -C ./config/sidekiq.yml