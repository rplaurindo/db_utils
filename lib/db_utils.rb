# require "rake/application"
# require "rake/task"

LIB_PATH = File.expand_path "../../lib", __FILE__
MONKEY_PATCHES_PATH = "#{LIB_PATH}/db_utils/support/monkey_patches"

module DBUtils

  # :: defines declaration to doesn't nesting to DBUtils module
  module ::Rails
    class Application

      # load tasks
      rake_tasks do
        Dir[File.join(LIB_PATH, "tasks", "**/*.rake")].each do |file|
          load file
        end

        Dir[File.join(MONKEY_PATCHES_PATH, "**/*.rake")].each do |file|
          load file
        end
      end

    end
  end

  # module ::Rake

  #   class << self

  #     def application
  #       @application ||= Rake::Application.new
  #     end

  #     def application=(app)
  #       @application = app
  #     end

  #     def original_dir
  #       application.original_dir
  #     end

  #     def load_rakefile(path)
  #       load(path)
  #     end

  #     def add_rakelib(*files)
  #       application.options.rakelib ||= []
  #       files.each do |file|
  #         application.options.rakelib << file
  #       end
  #     end

  #   end

  # end

  class Railtie < ::Rails::Railtie

    # Dir[File.join(MONKEY_PATCHES_PATH, "rails", "**/*.rb")].each do |file|
    #   # Rake.application.rake_require File.basename(file, '.rb'), Dir[File.join(MONKEY_PATCHES_PATH, "rails", "**/")]
    #   load file
    # end

    # config.autoload_paths += Dir["#{config.root}/initializers/monkey_patches/rails/**/"]

    # Dir[File.join(MONKEY_PATCHES_PATH, "rails", "**/*.rb")].each do |file|
    #   # require_dependency file
    #   require file
    # end

    # config.after_initialize do
    #   Dir[File.join(LIB_PATH, "**/*.rb")].each do |file|
    #     require file
    #   end
    # end

  end

end
