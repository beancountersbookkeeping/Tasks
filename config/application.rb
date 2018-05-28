require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'devise'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Workspace
  class Application < Rails::Application
   
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths << File.join(config.root, "lib")
  end
end
