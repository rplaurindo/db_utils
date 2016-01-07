module ActiveRecord
  module ConnectionHandling

    def establish_connection(spec = nil)
      # binding.pry
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
