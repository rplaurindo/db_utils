require "pry"

module TableMappingHelper
  module Rails

    extend self

    # works only called in another module
    protected
      def root_path
        File.expand_path "../../../../", __FILE__
      end

      def lib_path
        File.join(root_path, "lib")
      end

      def extensions_path
        File.join(root_path, "config/initializers/extensions")
      end

    class Engine < ::Rails::Engine

      extend Rails
      include Rails

      isolate_namespace Rails

      # with to_prepare will raise a error
      # após fazer iterar sobre os paths dos modelos, fazer include neles, levando-se em consideração a convenção de nomes para montá-los. Mas acho que o Rails já faz isso
      config.before_initialize do

        Dir[File.join(lib_path, "**/*.rb")].each do |file|
          require file
        end

      end

      # rake_tasks do
      #   Dir[File.join(extensions_path, "**/*.rake")].each do |file|
      #     load file
      #   end
      # end

    end

  end

  class Railtie < ::Rails::Railtie
    extend Rails

    # Dir[File.join(extensions_path, "**/*.rb")].each do |file|
    #   require file
    # end

  end

end
