module Beta
  module Configuration
    attr_accessor :redis, :namespace, :redirect_url, :uid, :environments
    
    def config
      yield self
    end

    def environments
      @environments ||= ["production"]
    end
  end
end