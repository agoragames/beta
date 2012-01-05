module Beta
  # AccessHelpers encapsulates the functionality for whitespacing.  This will
  # usually be included in ApplicationController and acccessed as before_filters
  module AccessHelpers
    # Uses redis whitelist and cookies to detect beta access. Redirects on failure.
    #
    # @param [String, nil] Location to redirect to on failure. Defaults to system config of Beta URL
    def whitelist redirection = nil
      return true unless Beta.environments.include?(::Rails.env)

      if cookies.signed["#{Beta.namespace}-beta"] == "#{Beta.namespace}-beta-#{request.remote_addr}"
        return true
      end

      return false unless current_user

      unless current_user_on_whitelist?
        redirect_to(redirection || Beta.redirect_url)
        return
      end

      cookies.signed["#{Beta.namespace}-beta"] = "#{Beta.namespace}-beta-#{request.remote_addr}"
    end

    # Uses redis whitelist to detect if the given user has beta access
    #
    # @param [User] the user to be checked against the list
    def is_whitelisted? user
      Beta.redis.sismember("#{Beta.namespace}:#{::Rails.env}:beta", user.try(Beta.uid))
    end

    # Uses `is_whitelisted?` with the value of `current_user`
    def current_user_on_whitelist?
      is_whitelisted? current_user
    end
  end
end
