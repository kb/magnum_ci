require 'webrat/selenium'
require 'webrat_extension'
require 'database_cleaner'

# Whether or not to run each scenario within a database transaction.
#
# If you leave this to true, you can turn off traqnsactions on a
# per-scenario basis, simply tagging it with @no-txn
Cucumber::Rails::World.use_transactional_fixtures = false

Webrat.configure do |config|
  config.mode = :selenium
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

World(Webrat::Selenium::Matchers)

DatabaseCleaner.strategy = :truncation, {:except => %w[config]}

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end