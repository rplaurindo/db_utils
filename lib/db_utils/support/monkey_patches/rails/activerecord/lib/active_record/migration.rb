module ActiveRecord

  class Migrator#:nodoc:

    class << self

      def migrations(paths)
        paths = Array(paths)

        files = Dir[*paths.map { |p| "#{p}/[0-9]*_*.rb" }]

        migrations = files.map do |file|
          version, name, scope = file.scan(/([0-9]+)_([_a-z0-9]*)\.?([_a-z0-9]*)?\.rb\z/).first

          raise IllegalMigrationNameError.new(file) unless version
          version = version.to_i
          name = name.camelize

          MigrationProxy.new(name, version, file, scope)
        end

        migrations.sort_by(&:version)
      end

    end
  end
end

