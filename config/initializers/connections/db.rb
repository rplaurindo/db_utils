module DBUtils
  module Connections

    class << self
      # já é enxergável?
      def connect namespace = nil
        db_config = YAML::load_file('config/database.yml')
        if namespace
          ActiveRecord::Base.establish_connection db_config[namespace][Rails.env]
        else
          ActiveRecord::Base.establish_connection db_config[Rails.env
        end
      end
    end

  end
end
