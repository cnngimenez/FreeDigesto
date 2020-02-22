# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_FreeDigesto_session',
  :secret      => '9c77f7ce76c0111918032b233709a006f625f6f3185b258f9d5073c2ec68845f9200ed0fbfe4fa4b8d497425fb17d265e6b7e42967c2d9508c987630d9774641'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
