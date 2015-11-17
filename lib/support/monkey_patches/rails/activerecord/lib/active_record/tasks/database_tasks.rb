# require 'active_support/core_ext/string/filter'

module ActiveRecord
  module Tasks
    module DatabaseTasks

      def each_current_configuration(environment)
        environments = [environment]
        # add test environment only if no RAILS_ENV was specified.
        environments << 'test' if environment == 'development' && ENV['RAILS_ENV'].nil?

        db_configs = ActiveRecord::Base.configurations
        configurations = []

        if ENV['NAMESPACE']
          namespaces = [ENV['NAMESPACE']]
        else
          namespaces = ENV['NAMESPACES'] ? ENV['NAMESPACES'].split(",") : []
        end

        namespaces_configs = db_configs.values_at(*namespaces)

        if namespaces_configs.any?
          namespaces_configs.each do |namespace|
            configurations << namespace.values_at(*environments)
          end
        end

        configurations << db_configs.values_at(*environments)

        configurations.flatten.compact.each do |configuration|
          yield configuration unless configuration['database'].blank?
        end
      end

      def create(*arguments)
        configuration = arguments.first

        begin
          class_for_adapter(configuration['adapter']).new(*arguments).create
        rescue DatabaseAlreadyExists
          $stderr.puts "#{configuration['database']} already exists"
        rescue Exception => error
          $stderr.puts error, *(error.backtrace)
          $stderr.puts "Couldn't create database for #{configuration.inspect}"
        else
          $stderr.puts "Database #{configuration['database']} has been created"
        end
      end

      def migrate
        verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
        version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
        scope   = ENV['SCOPE']
        verbose_was, Migration.verbose = Migration.verbose, verbose
        Migrator.migrate(migrations_paths, version) do |migration|
          scope.blank? || scope == migration.scope
        end
      ensure
        Migration.verbose = verbose_was
      end

    end

  end
end
