require 'webrat/core/matchers'
require 'cucumber/rails/rspec'

# Whether or not to run each scenario within a database transaction.
#
# If you leave this to true, you can turn off traqnsactions on a
# per-scenario basis, simply tagging it with @no-txn
Cucumber::Rails::World.use_transactional_fixtures = true

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end