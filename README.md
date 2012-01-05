# Beta [![Build Status](https://secure.travis-ci.org/agoragames/beta.png)](https://secure.travis-ci.org/agoragames/beta.png)

Beta is an access control library that uses a Redis whitelist to control authorization.
It relies upon the Rails.env variable to check against its list of environments to 
trigger on.

# Install

Install with `gem install beta` or add `gem 'beta'` to your Gemfile.

Then, add an initializer to our Rails app to configure Beta:

``` ruby
Beta.config do |config|
  redis = $redis
  uid = 'mlg_id'
  namespace    = 'awesome-app'
  redirect_url = 'http://majorleaguegaming.com'
  environments = [:production]
end
```

Finally, Beta requires the existence of a `current_user` to use the 
`whitelist` or `current_user_on_whitelist?` methods.

# Usage

By adding `include Beta::AccesHelpers` to ApplicationController, you get access to
the following methods:

* `whitelist` - Used as a before\_filter to ensure the `current_user` has access
* `is_whitelisted?(user)` checks to see if the given user is on the list.
* `current_user_on_whitelist?` leverages `is_whitelisted?` to tell you if the current user is special. Requires the existence of a `current_user` method.

