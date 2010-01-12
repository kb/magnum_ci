# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_coderunner_session',
  :secret      => '1fc2b02ff8ebbe6b338ea7f1b85aa6b39326bc9f4060db7bd572f698dddf4992953c70b99de5d59df38131b78e7effa13da81ff92f34b3e77493c203925dc837'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
