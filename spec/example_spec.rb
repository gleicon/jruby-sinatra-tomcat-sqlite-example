require File.dirname(__FILE__) + '/spec_helper'

describe 'A simple rspec test' do
	include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should a text" do
	end

end


