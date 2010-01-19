require 'machinist/active_record'
require 'sham'
require 'faker'

Dir["#{RAILS_ROOT}/spec/blueprints/*.rb"].each { |f| require f }