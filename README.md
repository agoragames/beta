# Beta

Beta is an access control library that uses a Redis whitelist to control authorization.

# Install

`gem install beta`

or

`gem 'beta'`

# Usage

First we setup our initializer.

``` ruby
Beta.config do |config|
  redis = $redis
  uid = 'mlg_id'
  namespace    = 'awesome-app'
  redirect_url = 'http://majorleaguegaming.com'
  environments = [:production]
end
```

Then, in our controller, include our access helpers and add the before filter:

```
include Beta::AccessHelpers
before_filter :whitelist

```

Requires the existence of a `current_user` method.

## Other helpers

* `is_whitelisted?(user)` checks to see if the given user is on the list.
* `current_user_on_whitelist?` leverages `is_whitelisted?` to tell you if the current user is special. Requires the existence of a `current_user` method.