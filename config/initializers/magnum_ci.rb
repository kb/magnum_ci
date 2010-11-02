require 'grit'
include Grit

require 'shell'

APP_CONFIG = YAML.load(File.read(Rails.root.to_s + '/config/config.yml'))[Rails.env]