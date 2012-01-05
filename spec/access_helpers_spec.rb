require 'spec_helper'

class HelperInstance
  include Beta::AccessHelpers

  def current_user
    User.new
  end
end

class User
  def uid
    35
  end
end

describe Beta::AccessHelpers do
  before(:each) do
    @redis = Redis.new
    @redis.flushdb

    Beta.config do |config|
      config.redis = @redis
      config.namespace = 'gem'
      config.redirect_url = 'http://www.site.com/not-authorized'
      config.uid = 'uid'
    end
  end

  describe "#is_whitelisted?" do
    it 'should return true if a user is whitelisted' do
      user = User.new
      helper = HelperInstance.new
      @redis.sadd("#{Beta.namespace}:#{::Rails.env}:beta", user.uid)
      helper.is_whitelisted?(user).should be(true)
    end

    it 'should return false if a user is not whitelisted' do
      user = User.new
      helper = HelperInstance.new
      helper.is_whitelisted?(user).should be(false)
    end
  end

  describe "current_user_on_whitelist?" do
    it 'should return true if a user is on whitelist' do
      helper = HelperInstance.new
      @redis.sadd("#{Beta.namespace}:#{::Rails.env}:beta", 35)
      helper.current_user_on_whitelist?.should be(true)
    end

    it 'should return false if a user is not the whitelist' do
      user = User.new
      helper = HelperInstance.new
      helper.current_user_on_whitelist?.should be(false)
    end
  end
end