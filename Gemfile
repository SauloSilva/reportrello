source "https://rubygems.org"
ruby "2.2.3"

gem 'sinatra', '1.4.6'
gem 'sinatra-contrib', '1.4.6'
gem 'sidekiq', '5.2.8'

gem 'sinatra-activerecord', '2.0.9'
gem 'pg', '0.18.4'

gem 'sinatra-flash', '0.3.0'

gem 'haml', '4.0.7'
gem 'sinatra-asset-pipeline', '0.7.0'

gem 'activesupport', '4.2.5'
gem 'ruby-trello', '1.3.0'
gem 'puma', '2.15.3'

gem 'pdfkit', '0.8.2'
gem 'uglifier', '2.7.2'

group :development, :test do
  gem 'tux', '0.3.0'
  gem 'pry', '0.10.3'
  gem 'shotgun', '0.9.1'
  gem 'wkhtmltopdf-binary', '0.9.9.3'
end

group :development do
  gem 'foreman', '0.75.0'
end

group :staging, :production do
  gem 'wkhtmltopdf-heroku', '2.12.2.4'
end