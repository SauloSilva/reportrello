require 'rubygems'
require 'bundler'
require 'pathname'
Bundler.require

require 'sinatra/asset_pipeline'
require 'pdfkit'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Sinatra configuration
configure do
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  set :assets_prefix, %w(app/assets vendor/assets)
  set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg *.eot *.ttf *.woff *.woff2)
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier

  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SESSION_KEY'] || 'reportrello'

  set :views, File.join(Sinatra::Application.root, 'app', 'views')
  register Sinatra::AssetPipeline

  use PDFKit::Middleware
end

# Load the models
Dir[APP_ROOT + 'app/models/**/*.rb'].each { |file| require file }

# Load the routes
require File.join(Sinatra::Application.root, 'app', 'actions', '_base')
Dir[APP_ROOT + 'app/actions/**/*.rb'].each { |file| require file }