Bundler.require
require './config'

namespace :db do
  desc "Run migrations"
  task :migrate => [:setup] do
    Sequel::Migrator.run(@database, "db/migrations")
  end

  desc "Reset database"
  task :reset => [:setup] do
    Sequel::Migrator.run(@database, "db/migrations", :target => 0)
    Sequel::Migrator.run(@database, "db/migrations")
  end

  task :setup do
    Sequel.extension :migration
    @database = Sequel.sqlite(IdeaBox::Config.database_uri)
  end
end
