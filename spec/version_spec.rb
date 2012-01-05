require 'spec_helper'

describe 'Beta::VERSION' do
  it 'should be the correct version' do
    Beta::VERSION.should eql('0.0.2')
  end
end