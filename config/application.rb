require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RocketLeagueBot
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.secret_key_base = Figaro.env.secret_key_base

    Raven.configure do |config|
      config.dsn = Figaro.env.sentry_key
    end
  end
end
