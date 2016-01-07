module ActiveRecord

  class Migrator#:nodoc:

    def initialize(direction, migrations, target_version = nil)
      raise StandardError.new("This database does not yet support migrations") unless Base.connection.supports_migrations?

      @direction         = direction
      @target_version    = target_version
      @migrated_versions = nil
      @migrations        = migrations

      validate(@migrations)

      # aqui, parece-me, que já há uma conexão
      binding.pry
      Base.connection.initialize_schema_migrations_table
    end

    class << self


      def up(migrations_paths, target_version = nil)
        migrations = migrations(migrations_paths)
        # Rails.application.config.database_configuration
        binding.pry
        migrations.select! do |m|
          yield m
        end if block_given?

        new(:up, migrations, target_version).migrate
      end

      def migrations(paths)
        paths = Array(paths)

        files = Dir[*paths.map { |p| "#{p}/[0-9]*_*.rb" }]

        migrations = files.map do |file|
          version, name, scope = file
            .scan(/([0-9]+)_([_a-z0-9]*)\.?([_a-z0-9]*)?\.rb\z/).first

          raise IllegalMigrationNameError.new(file) unless version
          version = version.to_i
          name = name.camelize

          MigrationProxy.new(name, version, file, scope)
        end

        migrations.sort_by(&:version)
      end

      # def migrate(migrations_paths, target_version = nil, &block)
      def migrate(migrations_path, target_version = nil, &block)
        case
        when target_version.nil?
          up(migrations_path, target_version, &block)
        when current_version == 0 && target_version == 0
          []
        when current_version > target_version
          down(migrations_path, target_version, &block)
        else
          up(migrations_path, target_version, &block)
        end
      end

    end
  end
end
