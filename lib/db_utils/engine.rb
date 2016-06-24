module DBUtils

  # works only called in another module
  protected
    def root_path
      File.expand_path "../../../", __FILE__
    end

    def lib_path
      File.join(root_path, "lib")
    end

    def extensions_path
      File.join(root_path, "config/initializers/extensions")
    end

  module Rails

    class Engine < ::Rails::Engine
      extend DBUtils

      isolate_namespace DBUtils


      config.after_initialize do
        Dir[File.join(lib_path, "**/*.rb")].each do |file|
          require file
        end
      end

      rake_tasks do
        Dir[File.join(extensions_path, "**/*.rake")].each do |file|
          load file
        end
      end

      class Railtie < ::Rails::Railtie

        extend DBUtils

        Dir[File.join(extensions_path, "**/*.rb")].each do |file|
          require file
        end

      end

    end
  end
end
