module DBUtils
  module Connection

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

      # called only once by module or class that include it
      def included who_add
        connect who_add.name.deconstantize.downcase
        who_add.table_name = "users"
      end

    end

  end
end
