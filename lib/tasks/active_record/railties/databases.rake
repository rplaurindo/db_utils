namespace :db do

  Rake::Task["db:migrate"].clear

  # desc "Bla Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate => [:environment, :load_config] do
    ActiveRecord::Tasks::DatabaseTasks.migrate
    # db_namespace['_dump'].invoke
  end

  Rake::Task["db:create"].clear

  desc 'Bla Creates the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:create:all to create all databases in the config). Without RAILS_ENV it defaults to creating the development and test databases.'
  # task :create => [:load_config] do
  # task :create => [:environment, :load_config] do
  task :create => [:environment, :load_config] do |t, args|
    ActiveRecord::Tasks::DatabaseTasks.create_current
  end

  # task :_dump do
  #   if ActiveRecord::Base.dump_schema_after_migration
  #     case ActiveRecord::Base.schema_format
  #     when :ruby then db_namespace["schema:dump"].invoke
  #     when :sql  then db_namespace["structure:dump"].invoke
  #     else
  #       raise "unknown schema format #{ActiveRecord::Base.schema_format}"
  #     end
  #   end
  #   # Allow this task to be called as many times as required. An example is the
  #   # migrate:redo task, which calls other two internally that depend on this one.
  #   db_namespace['_dump'].reenable
  # end

  # namespace :schema do
  #   desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  #   task :dump => [:environment, :load_config] do
  #     # mudar esse paradigma
  #     require 'active_record/schema_dumper'
  #     filename = ENV['SCHEMA'] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'schema.rb')
  #     File.open(filename, "w:utf-8") do |file|
  #       ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
  #     end
  #     db_namespace['schema:dump'].reenable
  #   end
  # end

end
