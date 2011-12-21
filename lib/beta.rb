require "beta/version"

class Beta
  class << self
    attr_accessor :redis, :namespace, :redirect_url, :uid
    def config
      yield self
    end
  end
  
  # AccessHelpers encapsulates the functionality for whitespacing.  This will 
  # usually be included in ApplicationController and acccessed as before_filters
  module AccessHelpers
    # Uses redis whitelist and cookies to detect beta access
    #
    # @param [String, nil] Location to redirect to on failure. Defaults to system config of Beta URL
    def whitelist(redirection = nil)
      return true unless Rails.env.production?

      if cookies.signed["#{Beta.namespace}-beta"] == "#{Beta.namespace}-beta-#{request.remote_addr}"
        return true
      end

      return false unless authenticate

      unless Beta.redis.sismember("#{Beta.namespace}:#{Rails.env}:beta", current_user.try(Beta.uid))
        redirect_to(redirection || Beta.redirect_url)
        return
      end

      cookies.signed["#{Beta.namespace}-beta"] = "#{Beta.namespace}-beta-#{request.remote_addr}"
    end
  end
end
