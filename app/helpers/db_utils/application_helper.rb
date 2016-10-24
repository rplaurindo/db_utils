module DBUtils
  module ApplicationHelper

    extend self

    def application
      ::Rails.application
    end

    def models
      application.config.eager_load_paths = models_eager_load_path
      application.eager_load!

      models = Module.select_nestings do |const|
        const if const.is_a?(Class) && const != ActiveRecord::SchemaMigration && (const.extends?(ActiveRecord::Base) || const.include?(ActiveModel::Model))
      end
    end

    private

      def models_eager_load_path
        application.config.eager_load_paths.select do |abs_path|
          match_path = nil
          application.config.paths["app/models"].select do |path|
            match_path = true if Regexp.new("(#{path})$").match abs_path
          end
          abs_path if match_path
        end
      end

  end

end
