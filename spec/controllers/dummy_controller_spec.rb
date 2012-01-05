require 'spec_helper'

describe DummyController do
  before(:each) do
    @redis = Redis.new
    @redis.flushdb

    Beta.config do |config|
      config.redis = @redis
      config.namespace = 'gem'
      config.redirect_url = 'http://www.site.com/not-authorized'
      config.uid = 'uid'
      config.environments = ["test"]
    end
  end

  it 'should redirect if user is not whitelisted' do
    get 'index'

    response.should be_redirect
    response.should redirect_to('http://www.site.com/not-authorized')
    response.cookies.should be_empty
  end

  it 'should not redirect if user is whitelisted' do
    Beta.redis.sadd("#{Beta.namespace}:#{::Rails.env}:beta", 35)
    get 'index'

    response.should be_ok
    response.cookies.should_not be_empty
    response.cookies["#{Beta.namespace}-beta"].should_not be_nil
  end
end