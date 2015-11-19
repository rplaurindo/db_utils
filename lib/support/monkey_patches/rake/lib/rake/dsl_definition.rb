module Rake
  module DSL

    def file(*args, &block) # :doc:
      $stdout.puts "file method. Called of: #{caller[0]}"
      Rake::FileTask.define_task(*args, &block)
      yield if block_given?
    end

  end
end