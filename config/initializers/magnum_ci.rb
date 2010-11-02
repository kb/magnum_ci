require 'grit'
include Grit

require 'shell'

APP_CONFIG = YAML.load(File.read(Rails.root + "/config/config.yml"))[RAILS_ENV]