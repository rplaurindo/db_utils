module ActiveRecord
  module Tasks
    module DatabaseTasks

      def migrations_paths
        paths = Rails.application.paths['db/migrate'].to_a
        namespaces = []
        root_path = paths.first

        if ENV['NAMESPACE']
          namespaces = [ENV['NAMESPACE']]
        elsif ENV['NAMESPACES']
          namespaces = ENV['NAMESPACES'] ? ENV['NAMESPACES'].split(",") : []
        end

        if namespaces.any?
          namespaces.each do |namespace|
            paths << "#{root_path}/#{namespace}"
          end
        end

        @migrations_paths ||= paths
      end

      # commited
      # def create(*arguments)
      #   configuration = arguments.first
      #   begin
      #     class_for_adapter(configuration['adapter']).new(*arguments).create
      #   rescue DatabaseAlreadyExists
      #     $stderr.puts "#{configuration['database']} already exists"
      #   rescue Exception => error
      #     $stderr.puts error, *(error.backtrace)
      #     $stderr.puts "Couldn't create database for #{configuration.inspect}"
      #   else
      #     $stderr.puts "Database #{configuration['database']} has been created"
      #   end
      # end

      private

      def each_current_configuration(environment)
        environments = [environment]
        # add test environment only if no RAILS_ENV was specified.
        environments << 'test' if environment == 'development' && ENV['RAILS_ENV'].nil?
        db_configs = ActiveRecord::Base.configurations
        configurations = []

        if ENV['NAMESPACE']
          namespaces = [ENV['NAMESPACE']]
        else ENV['NAMESPACES']
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

    end

  end
end
