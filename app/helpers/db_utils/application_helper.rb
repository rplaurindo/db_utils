module DBUtils
  module ApplicationHelper

    extend self

    def models
      application.config.eager_load_paths = model_eager_load_paths
      application.eager_load!

      models = Module.collect do |const|
        const if const.is_a?(Class) && const != ActiveRecord::SchemaMigration && (const.extends?(ActiveRecord::Base) || const.include?(ActiveModel::Model))
      end
    end

    private

      def application
        ::Rails.application
      end

      def model_eager_load_paths
        eager_load_paths = application.config.eager_load_paths.collect do |eager_load_path|
          model_paths = application.config.paths["app/models"].collect do |model_path|
            eager_load_path if Regexp.new("(#{model_path})$").match(eager_load_path)
          end
        end.flatten.compact
      end

  end

end
