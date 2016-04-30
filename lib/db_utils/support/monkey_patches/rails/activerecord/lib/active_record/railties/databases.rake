load 'active_record/railties/databases.rake'

Rake::Task["railties:install:migrations"].clear

namespace :railties do
  namespace :install do
    # desc "Copies missing migrations from Railties (e.g. engines). You can specify Railties to use with FROM=railtie1,railtie2"
    task :migrations => :'db:load_config' do
      to_load = ENV['FROM'].blank? ? :all : ENV['FROM'].split(",").map {|n| n.strip }
      railties = {}
      namespace = ''
      Rails.application.migration_railties.each do |railtie|
        next unless to_load == :all || to_load.include?(railtie.railtie_name)
        namespace = railtie.railtie_name

        if railtie.respond_to?(:paths) && (path = railtie.paths['db/migrate'].first)
          railties[railtie.railtie_name] = path
        end
      end

      on_skip = Proc.new do |name, migration|
        puts "NOTE: Migration #{migration.basename} from #{name} has been skipped. Migration with the same name already exists."
      end

      on_copy = Proc.new do |name, migration|
        puts "Copied migration #{migration.basename} from #{name}"
      end

      binding.pry
      ActiveRecord::Migration.copy("#{ActiveRecord::Migrator.migrations_paths.first}/#{namespace}", railties,
                                    :on_skip => on_skip, :on_copy => on_copy)
    end
  end
end
