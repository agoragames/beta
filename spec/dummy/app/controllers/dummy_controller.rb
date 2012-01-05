class DummyController < ApplicationController
  include Beta::AccessHelpers
  
  def index
    @user = params[:user] || "David"
  end
end