# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tensoon2_session',
  :secret      => '3d363962e277ac25ad5fec90b1d8b5eda061a6723d5d764b4b34102960cf6bf96648e6cd105d085721e01a3164d220b9382775f3654b0b85ee9b0c6121e21b0e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
