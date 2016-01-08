module ActiveRecord
  module ConnectionAdapters
    class ConnectionSpecification #:nodoc:
      # attr_reader :config, :adapter_method

      class Resolver # :nodoc:
        # attr_reader :configurations

        private

        def resolve_hash_connection(spec)
          if spec["url"] && spec["url"] !~ /^jdbc:/
            connection_hash = resolve_url_connection(spec.delete("url"))
            spec.merge!(connection_hash)
          end

          # a conexão deve ser feita pelo diretório atual da migração e por isso, talvez será interessante o método iterador em Migrator.migrate
          # if (namespaced = spec.values_at(Rails.env).first)
          #   binding.pry
          #   spec = namespaced
          # end

          # binding.pry

          spec
        end

      end
    end
  end
end
