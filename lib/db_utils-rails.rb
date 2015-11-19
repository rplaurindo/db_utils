require "byebug"

# p Dir[File.join(ROOT_PATH, "lib/support", "**/*.rb")]

ROOT_PATH = File.expand_path "../../", __FILE__

module DBUtils

  # include Rails
  # extend Rails

  # os :: antes informa que não é para encapsular ao modulo DBUtils
  module ::Rails
    class Application

      rake_tasks do

        Dir[File.join(ROOT_PATH, "lib/tasks", "**/*.rake")].each do |file|
          load file
        end

      end

    end
  end

  class Railtie < ::Rails::Railtie

    config.after_initialize do

      Dir[File.join(ROOT_PATH, "lib/support", "**/*.rb")].each do |file|
        require file
      end

    end

  end

end
