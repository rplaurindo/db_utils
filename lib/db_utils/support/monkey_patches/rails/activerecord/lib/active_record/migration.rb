module ActiveRecord

  # class Migration

  #   def copy(destination, sources, options = {})
  #     destination = "#{destination}/#{ENV['FROM']}" if ENV['FROM']
  #     copied = []

  #     FileUtils.mkdir_p(destination) unless File.exist?(destination)

  #     destination_migrations = ActiveRecord::Migrator.migrations(destination)
  #     last = destination_migrations.last
  #     sources.each do |scope, path|
  #       source_migrations = ActiveRecord::Migrator.migrations(path)

  #       source_migrations.each do |migration|
  #         source = File.binread(migration.filename)
  #         inserted_comment = "# This migration comes from #{scope} (originally #{migration.version})\n"
  #         if /\A#.*\b(?:en)?coding:\s*\S+/ =~ source
  #           # If we have a magic comment in the original migration,
  #           # insert our comment after the first newline(end of the magic comment line)
  #           # so the magic keep working.
  #           # Note that magic comments must be at the first line(except sh-bang).
  #           source[/\n/] = "\n#{inserted_comment}"
  #         else
  #           source = "#{inserted_comment}#{source}"
  #         end

  #         if duplicate = destination_migrations.detect { |m| m.name == migration.name }
  #           if options[:on_skip] && duplicate.scope != scope.to_s
  #             options[:on_skip].call(scope, migration)
  #           end
  #           next
  #         end

  #         migration.version = next_migration_number(last ? last.version + 1 : 0).to_i
  #         new_path = File.join(destination, "#{migration.version}_#{migration.name.underscore}.rb")
  #         old_path, migration.filename = migration.filename, new_path
  #         last = migration

  #         File.binwrite(migration.filename, source)
  #         copied << migration
  #         options[:on_copy].call(scope, migration, old_path) if options[:on_copy]
  #         destination_migrations << migration
  #       end
  #     end

  #     copied
  #   end

  # end

  class Migrator#:nodoc:

    class << self

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
