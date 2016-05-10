module DBUtils
  module Connector

    class << self

      # to recognize who include (module and class) to connect automatically
      def connect namespace = nil
        namespace = namespace.to_s
        db_config = YAML::load_file('config/database.yml')
        if namespace
          ActiveRecord::Base
            .establish_connection db_config[namespace][Rails.env]
        else
          ActiveRecord::Base.establish_connection db_config[Rails.env]
        end
      end

      private

        def has_module? who_included
          who_included.name.deconstantize.downcase
        end

        def resolve_class_name who_included
          who_included.name.demodulize.downcase.pluralize
        end

        # called only once by module or class that include it
        def included who_included
          if module_name = has_module?(who_included)
            connect module_name
            who_included.table_name = resolve_class_name(who_included)
          end
        end

    end

  end
end
