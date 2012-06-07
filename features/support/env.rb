init_file = File.join(File.dirname(__FILE__), *%w[.. .. init])

require init_file

Sinatra::Application.app_file = init_file

require 'spec/expectations'
require 'rack/test'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack
end

class SinatraExample 
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body

  def app
    Sinatra::Application
  end
end

World{SinatraExample.new}

