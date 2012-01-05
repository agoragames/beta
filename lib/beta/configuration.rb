module Beta
  module Configuration
    attr_accessor :redis, :namespace, :redirect_url, :uid
    
    def config
      yield self
    end
  end
end