class DummyController < ApplicationController
  include Beta::AccessHelpers
  before_filter :whitelist
  
  def index
    @user = params[:user] || "David"
  end

  def current_user
    User.new
  end

  def authenticate
    true
  end
end