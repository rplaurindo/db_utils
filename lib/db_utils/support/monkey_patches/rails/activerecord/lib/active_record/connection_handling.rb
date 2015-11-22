module ActiveRecord
  module ConnectionHandling

    RAILS_ENV   = -> { (Rails.env if defined?(Rails.env)) || ENV["RAILS_ENV"] || ENV["RACK_ENV"] }
    DEFAULT_ENV = -> { RAILS_ENV.call || "default_env" }

    # coé dessa parada aqui no ruby, ou Rails, sei lá.

    def establish_connection(spec = nil)
      # aqui já se pode definir o caso de namespace estar nil, verificar se há ENV["NAMESPACE"], devendo a variável spec ser melhor tratada

      binding.pry

      # essa linha está errada
      spec     ||= DEFAULT_ENV.call.to_sym
      resolver =   ConnectionAdapters::ConnectionSpecification::Resolver.new configurations

      binding.pry
      spec     =   resolver.spec(spec)

      unless respond_to?(spec.adapter_method)
        raise AdapterNotFound, "database configuration specifies nonexistent #{spec.config[:adapter]} adapter"
      end

      remove_connection
      connection_handler.establish_connection self, spec
    end

  end
end
