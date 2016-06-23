ROOT_PATH = File.expand_path "../../..", __FILE__
LIB_PATH = File.join(ROOT_PATH, "lib")
EXTENSIONS_PATH = File.join(ROOT_PATH, "config/initializers/extensions")

module DBUtils
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace DBUtils

      config.after_initialize do
        Dir[File.join(LIB_PATH, "**/*.rb")].each do |file|
          require file
        end
      end

      rake_tasks do
        Dir[File.join(EXTENSIONS_PATH, "**/*.rake")].each do |file|
          load file
        end
      end

      class Railtie < ::Rails::Railtie

        Dir[File.join(EXTENSIONS_PATH, "rails", "**/*.rb")].each do |file|
          require file
        end

      end

    end
  end
end
