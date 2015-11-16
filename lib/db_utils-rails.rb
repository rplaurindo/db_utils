# adicionar $LOAD_PATH e dar require nos arquivos .rb

require "byebug"

module DBUtils

  ROOT_PATH = File.expand_path "../../", __FILE__
  # os :: antes informa que não é para encapsular ao modulo DBUtils
  module ::Rails
    class Application
      rake_tasks do
        Dir[File.join(ROOT_PATH, "/lib/tasks/", "**/*.rake")].each do |file|
          load file
        end
      end
    end
  end

  # ver questão do initialize

end
