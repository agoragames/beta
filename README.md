# Beta

Beta is an access control library that uses a Redis whitelist to control authorization.

# Usage

# config/initializer/beta.rb
Beta.config do |config|
  redis = $redis 
  uid = 'mlg_id'
  namespace    = 'awesome-app'
  redirect_url = 'http://majorleaguegaming.com'
end

# app/controllers/application_controller.rb
include Beta::AccessHelpers
before_filter :whitelist 

Requires the existence of a `current_user` method
