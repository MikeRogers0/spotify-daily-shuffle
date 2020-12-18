require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SpotifyPlaylistShuffler
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Let me folder up my I18n's.
    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]

    # Don't make most the unit tests in scaffolding.
    config.generators do |g|
      g.system_tests = false
      g.helper false
      g.assets false
      g.helper false
      g.view_specs false
      g.decorator false
    end

    # Enable serving of images, stylesheets, and JavaScripts from an CDN server.
    config.action_controller.asset_host = ENV['ASSET_HOST'] if ENV['ASSET_HOST']

    # When visiting an external HTTP link, don't send a referrer
    config.action_dispatch.default_headers.merge!({
                                                    'Referrer-Policy' => 'no-referrer-when-downgrade'
                                                  })
  end
end
