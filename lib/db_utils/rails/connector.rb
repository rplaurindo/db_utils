module DBUtils
  module Rails
    module Connector

      class << self

        @who_included = nil
        @module = nil

        # to recognize who include (module and class) to connect automatically
        def connect namespace = nil

          # @who_included.table_name = resolve_class_name
          # o reload deve ser feito aqui?
          # binding.pry
          # namespace = namespace.to_s
          # db_config = YAML::load_file('config/database.yml')
          # # tentar fazer include aos modelos do projeto dinamicamente por aqui, para tal deve-se pegar todos os modelos, incluir um observador neles, e toda vez que forem chamados esse módulo deve ser incluído, ou o método deve ser chamado.
          # # Um outra solução é incluir este mṕdulo a todos os modelos, sem a intervenção do usuário, neste caso um observador não seria necessário.
          # # ou, talvez tenha que usar os dois, incluir em todas, e quando chamadas executar o método connect
          # # binding.pry
          # if namespace
          #   # try
          #   begin
          #     ActiveRecord::Base
          #       .establish_connection db_config[namespace][::Rails.env]
          #   # catch
          #   rescue => details
          #     $stderr.puts "Could not possible connect to database with namespace \"#{namespace}.\""
          #     $stderr.puts "Details: #{details}."
          #   # throw
          #   # raise
          #   end
          # else
          #   ActiveRecord::Base.establish_connection db_config[::Rails.env]
          # end

          # reload_model!
        end

        private

          # called only once by module or class that include it
          def included who_included
            @who_included = who_included
            @module = has_module?
            if @module && @module.name.underscore != "active_record"
              connect
            end
          end

          def has_module?
            module_name = @who_included.name.deconstantize
            module_name.constantize unless module_name.empty?
          end

          def reload_model!
            Object.send :remove_const, @who_included.name.to_sym
            require_model_file
          end

          def require_model_file
            require_model_files.each do |file|
              require file
            end
          end

          def require_model_files
            name = @who_included.name.underscore
            module_name = @module.name.underscore
            # binding.pry
            if module_name
              # ::Rails.application.config.paths["app/models"].select do |path|
              #   # binding.pry
              #   # verificar se arquivo existe, sei lá como
              #   # File.join path, module_name, name, ".rb" if
              # end
            else
              # ::Rails.application.config.paths["app/models"].select do |path|
              #   # binding.pry
              # end
            end
          end

          def resolve_class_name
            @who_included.name.demodulize.underscore.pluralize
          end

      end

    end
  end
end
