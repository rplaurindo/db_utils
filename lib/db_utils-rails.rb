module DBUtils

  LIB_PATH = File.expand_path "../../lib", __FILE__

  # os :: antes informa que não é para encapsular ao modulo DBUtils
  module ::Rails
    class Application

      # load as tasks
      rake_tasks do

        Dir[File.join(LIB_PATH, "db_utils/tasks", "**/*.rake")].each do |file|
          load file
        end

      end

    end
  end

  class Railtie < ::Rails::Railtie

    config.after_initialize do
      # require "byebug"

      Dir[File.join(LIB_PATH, "db_utils", "**/*.rb")].each do |file|
        require file
      end

    end

  end

end
