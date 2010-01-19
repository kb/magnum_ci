clear_sources
disable_system_gems

source 'http://gemcutter.org'
source 'http://gems.github.com'

gem 'rails', '2.3.5'
gem 'will_paginate', '2.3.11'
gem 'jeremydurham-restful_authentication', '1.1.6', :require_as => 'restful_authentication'
gem 'nokogiri', '1.4.0'
gem 'mongrel', '1.1.5'
gem 'sqlite3-ruby', '1.2.5'
gem 'jrails', '0.6.0'
gem 'resque'
gem 'json'

only :development do
  gem 'ruby-debug'
  gem 'annotate-models'
end

only :production do
  gem 'smurf', '1.0.3'
end

only :test do
  gem 'selenium-client', '1.2.17'
  gem 'machinist', '1.0.5'
  gem 'faker', '0.3.1'  
  gem 'database_cleaner', '0.2.3'
  gem 'pickle', '0.2.1'
  gem 'cucumber', '0.5.1'
  gem 'cucumber-rails', '0.2.1'
  gem 'webrat', '0.6.0'
  gem 'rspec', '1.2.9'
  gem 'rspec-rails', '1.2.9'
end

bundle_path 'vendor/bundled_gems'


