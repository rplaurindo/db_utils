# verificar se o modelo possui módulo, caso sim, pegá-lo;
# verificar recursivamente se seus módulos define ::Engine, caso sim, pegar seu diretório root ...::Engine.root
# se não encontrar, então não é engine, devendo ser procurado com auxílio do Rails.application.root
# fazer o remove_const com o const_get do módulo capturado
# pegar config.paths["app/models"], unir com o root para fazer require. Seguir padrão de nome de namespace para resolver path relativo ao modelo para tentar fazer o require

module Migreatest
  module Rails
    module Connector

      extend self

      @full_constant = nil
      @full_parent = nil

      # to recognize who include (module and class) to connect automatically
      def connect namespace = nil

        # @full_constant.table_name = resolve_class_name
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

        reload_model!
      end

      class << self

        private

          # called only once by module or class that include it
          def included constant
            @full_constant = constant.name.demodulize
            @full_parent = has_parent? constant
            if !@full_parent || @full_parent != ActiveRecord
              connect
            end
          end

      end

      private

        def has_parent? full_constant
            parent_name = full_constant.name.deconstantize
            parent_name.constantize unless parent_name.empty?
          end

          def reload_model!
            object = @full_parent ? Module.const_get(@full_parent.name.to_sym) : Class
            object.send :remove_const, @full_constant.name.demodulize.to_sym
            require_model_file
          end

          def model_paths
            ::Rails.application.config.paths["app/models"]
          end

          def require_model_file
            require_model_files.each do |file|
              require file
            end

            # constant_path = @full_constant.name.underscore
            # # module_name = @module.name.underscore
            # # files = model_paths.select do |path|
            # model_paths.each do |path|
            #   # para ficar direito vai ter de pegar a path das gems e colocar no $LOAD_PATH deste conexto
            #   file = File.join(path, "#{constant_path}.rb")
            #   binding.pry
            #   # file if File.exists? file
            #   require file
            # end
          end

          # talvez não seja mais necessário com o método Module.defines?, por causa da implementação de autoload do Rails
          def is_gem? name
            begin
              gem_specification = GEM::Specification.find_by_name(name)
            rescue
              false
            end
          end

          def require_model_files
            constant_name = @full_constant.name.underscore

            gem_name = @full_parent.name.parametrize
            files = []

            if gem_specification = is_gem?(gem_name)
              files = model_paths.select do |path|
                # ENV["GEM_HOME"]
                binding.pry
                # colocar com as especificações aqui
                # file = File.join(::Rails.root.parent, gem_name, path, "#{constant_name}.rb")
                # if File.exists? file
                #   file
                # else
                #   file = File.join(::Rails.root.parent, gem_name, path, "#{constant_name}.rb")
                #   file if File.exists? file
                # end
              end
            else
              ::Rails.application.config.paths["app/models"].select do |path|
                # binding.pry
              end
            end
          end

          def resolve_class_name
            @full_constant.name.demodulize.underscore.pluralize
          end

    end
  end
end
