require ::File.expand_path('../config/environment',  __FILE__)
require ::File.expand_path('../config/sidekiq',  __FILE__)

set :app_file, __FILE__

map '/' do
  if %w(staging production).include?(ENV['RACK_ENV'])
    use Rack::Auth::Basic, "Protected Area" do |username, password|
      username == ENV['APP_USERNAME'] && password == ENV['APP_PASSWORD']
    end
  end

  run Sinatra::Application
end

map '/sidekiq' do
  if %w(staging production).include?(ENV['RACK_ENV'])
    use Rack::Auth::Basic, "Protected Area" do |username, password|
      username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
    end
  end

  run Sidekiq::Web
end