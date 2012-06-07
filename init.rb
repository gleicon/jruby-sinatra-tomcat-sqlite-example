require 'rubygems'
require 'sinatra'
require 'mustache'
require 'data_mapper'
require 'base62'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  config_file = File.join(root, 'config', 'app.yml')
  begin
    app_config = YAML::load_file(config_file)
    set :base_url, app_config["base_url"]
  rescue
    set :base_url, 'http://localhost:9292/'
  end
  set :public_folder, File.join(root, 'app', 'static')                                   
  set :views, File.join(root, 'app', 'views')
  set :db_url, "sqlite3://#{root}/uurl.db"
end

DataMapper::setup(:default, settings.db_url)

class COUNTER
    include DataMapper::Resource
    property :uuid, Serial
end

class UURL
    include DataMapper::Resource
    property :id, Integer, :key => true
    property :e_url, Text
    property :url, Text, :key => true
    property :created_at, DateTime
    property :clicks, Integer
    property :base_url, String
end

DataMapper.finalize
COUNTER.auto_upgrade!
UURL.auto_upgrade!

helpers do                                                                                                                                                                      
  def mustacho(tpl, pars)                                                     
    Mustache.render(File.read(File.join(settings.views, tpl)), pars)        
  end                                                                         
end  

not_found do                                                                    
  status 404                                                                    
  mustacho "not_found.tpl", {}
end                                                                             

Dir["app/controllers/*.rb"].each { |file| load file }
