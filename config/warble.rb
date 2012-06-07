Warbler::Config.new do |config|
  config.dirs = %w(app config lib log vendor tmp)
  config.includes = FileList["init.rb", "uurl.db"]
  config.gems += ["sinatra", "mustache", "data_mapper", "base62", "dm-sqlite-adapter"]
  config.gems += ["activerecord-jdbcmysql-adapter"]
  config.gems -= ["rails"]
  config.war_name = "uurl"
  config.gem_dependencies = true
end
