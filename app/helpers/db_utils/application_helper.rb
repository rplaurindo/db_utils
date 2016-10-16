module DBUtils
  module ApplicationHelper

    extend self

    def models
      application = ::Rails.application
      application.config.eager_load_paths = [models_path]
      application.eager_load!
      models = []

      Module.constants.each do |constant_name|
        constant = eval constant_name.to_s
        models.push constant if constant.is_a?(Class) && (constant.extend?(ActiveRecord::Base) || constant.include?(ActiveModel::Model))
      end
      models
    end

    private
      # Sentinel::Rails::Engine.root
      def app_path
        File.join ::Rails.root, "app"
      end

      def models_path
        File.join app_path, "models"
      end

  end

end
