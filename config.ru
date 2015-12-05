require ::File.expand_path('../config/environment',  __FILE__)
require ::File.expand_path('../config/sidekiq',  __FILE__)

set :app_file, __FILE__
run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)