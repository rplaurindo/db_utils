require "yaml"

namespace :sentinel do
  namespace :db do

    desc "Run migrations or creates database and run migrations."

    # transformar em uma gem
    task :migrate, [:namespaces] => [:environment] do |t, params|

      extend Sentinel::Engine.helpers

      db_config = YAML::load_file('config/database.yml')

      migrations_path = File.expand_path("../../../../../db/migrate/#{engine_name}", __FILE__)
      env = Rails.env

      active_record_base = ActiveRecord::Base

      active_record_base.establish_connection db_config[engine_name][env]

      unless active_record_base.has_connection?
        Rake::Task["sentinel:db:create"].invoke(engine_name)
        active_record_base.establish_connection db_config[engine_name][env]
      end

      # .migrations_paths guarda um array, logo, caso haja namespaces, este deve ser tratado de forma diferente
      ActiveRecord::Migrator.migrations_paths= migrations_path

      begin
        Rake::Task["db:migrate"].invoke
      rescue => e
        p e
      end

    end

  end
end
