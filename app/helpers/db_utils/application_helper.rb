module DBUtils
  module ApplicationHelper

    extend self

    def application
      ::Rails.application
    end

    def models
      application.config.eager_load_paths = models_eager_load_path
      application.eager_load!
      models = []

      Module.constants.each do |constant_name|
        constant = eval constant_name.to_s
        models.push constant if constant.is_a?(Class) && (constant.extend?(ActiveRecord::Base) || constant.include?(ActiveModel::Model))
      end
      models
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
