require ::File.expand_path('../config/environment',  __FILE__)
require ::File.expand_path('../config/sidekiq',  __FILE__)

set :app_file, __FILE__

map '/' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'user' && password == '102030'
  end

  run Sinatra::Application
end

map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == '102030'
  end

  run Sidekiq::Web
end