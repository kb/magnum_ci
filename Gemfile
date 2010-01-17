clear_sources
disable_system_gems

source 'http://gemcutter.org'
source 'http://gems.github.com'

gem 'rails', '2.3.5'
gem 'jeremydurham-restful_authentication', '1.1.6', :require_as => 'restful_authentication'
gem 'nokogiri'
gem 'sqlite3-ruby'
gem 'jrails'
gem 'mongrel'
gem 'git'

only :development do
  gem 'ruby-debug'
end

only :production do
  gem 'smurf'
end

only :test do
  gem 'selenium-client'
  gem 'machinist'
  gem 'faker'  
  gem 'database_cleaner'
  gem 'pickle'
  gem 'cucumber'
  gem 'webrat'
  gem 'rspec'
  gem 'rspec-rails'
end

bundle_path 'vendor/bundled_gems'
