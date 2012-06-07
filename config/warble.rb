Warbler::Config.new do |config|
  config.dirs = %w(app config lib log vendor tmp)
  config.includes = FileList["init.rb"]
  config.gems += ["sinatra", "mustache", "data_mapper", "base62"]
  config.gems += ["activerecord-jdbcmysql-adapter", "jruby-openssl"]
  config.gems -= ["rails"]
  config.war_name = "uurl"
  config.gem_dependencies = true
end
