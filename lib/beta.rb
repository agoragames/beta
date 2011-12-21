require "beta/version"

class Beta
  class << self
    attr_accessor :redis, :namespace, :redirect_url, :uid
    def config
      yield self
    end
  end

  module AccessHelpers
    def whitelist
      return true unless Rails.env.production?

      if cookies.signed["#{Beta.namespace}-beta"] == "#{Beta.namespace}-beta-#{request.remote_addr}"
        return true
      end

      return false unless authenticate

      unless Beta.redis.sismember("#{Beta.namespace}:#{Rails.env}:beta", current_user.try(Beta.uid))
        redirect_to(Beta.redirect_url)
        return
      end

      cookies.signed["#{Beta.namespace}-beta"] = "#{Beta.namespace}-beta-#{request.remote_addr}"
    end
  end
end
