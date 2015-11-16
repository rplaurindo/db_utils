namespace :db do

  # só vou conseguir acessar aquele método usando Rake::Task, não executando direto em linhda de comando
  Rake::Task["db:create"].clear

  desc 'Bla Creates the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:create:all to create all databases in the config). Without RAILS_ENV it defaults to creating the development and test databases.'
  # task :create => [:load_config] do
  task :create => [:load_config, :environment] do
    ActiveRecord::Tasks::DatabaseTasks.create_current
  end

end
