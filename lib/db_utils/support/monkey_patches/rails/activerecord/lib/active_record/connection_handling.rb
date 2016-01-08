module ActiveRecord
  module ConnectionHandling

    class MergeAndResolveDefaultUrlConfig # :nodoc:
      def initialize(raw_configurations)
        @raw_config = raw_configurations.dup
        @env = DEFAULT_ENV.call.to_s
      end

      # Returns fully resolved connection hashes.
      # Merges connection information from `ENV['DATABASE_URL']` if available.
      def resolve
        ConnectionAdapters::ConnectionSpecification::Resolver.new(config).resolve_all
      end

      private
        def config
          @raw_config.dup.tap do |cfg|
            if url = ENV['DATABASE_URL']
              cfg[@env] ||= {}
              cfg[@env]["url"] ||= url
            end
          end
        end
    end

    def establish_connection(spec = nil)
      spec     ||= DEFAULT_ENV.call.to_sym
      resolver =   ConnectionAdapters::ConnectionSpecification::Resolver.new configurations

      spec     =   resolver.spec(spec)

      unless respond_to?(spec.adapter_method)
        raise AdapterNotFound, "database configuration specifies nonexistent #{spec.config[:adapter]} adapter"
      end

      remove_connection
      connection_handler.establish_connection self, spec
    end

  end
end
