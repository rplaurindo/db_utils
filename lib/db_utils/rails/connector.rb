module DBUtils
  module Rails
    module Connector

      class << self

        # to recognize who include (module and class) to connect automatically
        def connect namespace = nil
          namespace = namespace.to_s
          db_config = YAML::load_file('config/database.yml')
          # tentar fazer include aos modelos do projeto dinamicamente por aqui, para tal deve-se pegar todos os modelos, incluir um observador neles, e toda vez que forem chamados esse módulo deve ser incluído, ou o método deve ser chamado.
          # Um outra solução é incluir este mṕdulo a todos os modelos, sem a intervenção do usuário, neste caso um observador não seria necessário.
          # ou, talvez tenha que usar os dois, incluir em todas, e quando chamadas executar o método connect
          # binding.pry
          if namespace
            # try
            begin
              ActiveRecord::Base
                .establish_connection db_config[namespace][::Rails.env]
            # catch
            rescue => details
              $stderr.puts "Could not possible connect to database with namespace \"#{namespace}.\""
              $stderr.puts "Details: #{details}."
            # throw
            # raise
            end
          else
            ActiveRecord::Base.establish_connection db_config[::Rails.env]
          end
        end

        private

          def has_module? who_included
            who_included.name.deconstantize.underscore
          end

          def resolve_class_name who_included
            who_included.name.demodulize.underscore.pluralize
          end

          # called only once by module or class that include it
          def included who_included
            if module_name = has_module?(who_included)
              unless module_name == "active_record"
                connect module_name
                who_included.table_name = resolve_class_name(who_included)
              end
            end
          end

      end

    end
  end
end
