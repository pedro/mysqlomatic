# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mysqlomatic_session',
  :secret      => '7a772fc1e22065856e73e3a6e18e96c054155ef9654a120f5bec8b621ec5d2c3c6a6385ff8ae7ab97304f1c83d637ad81c41a89bc5e3274cedd7fe8262e26855'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
