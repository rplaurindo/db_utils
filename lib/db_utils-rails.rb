# adicionar $LOAD_PATH e dar require nos arquivos

require "byebug"

module DBUtils
  # extend and include aqui
  # Your code goes here...

  include Rails
  ROOT_PATH = File.expand_path "../../", __FILE__
  Application.rake_tasks do
    # mapear tasks em diretórios e subdiretórios dando load em todas
    load File.join(ROOT_PATH, "/lib/tasks/active_record/railties/databases.rake")
  end

end
