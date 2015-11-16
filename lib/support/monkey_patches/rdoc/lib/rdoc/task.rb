require "rdoc/task"

class RDoc::Task < Rake::TaskLib

  def define
    desc rdoc_task_description
    task rdoc_task_name

    desc rerdoc_task_description
    task rerdoc_task_name => [clobber_task_name, rdoc_task_name]

    desc clobber_task_description
    task clobber_task_name do
      rm_r @rdoc_dir rescue nil
    end

    task :clobber => [clobber_task_name]

    directory @rdoc_dir

    rdoc_target_deps = [
      @rdoc_files,
      Rake.application.rakefile
    ].flatten.compact

    task rdoc_task_name => [rdoc_target]
    args = option_list + @rdoc_files
    file rdoc_target => rdoc_target_deps do
      @before_running_rdoc.call if @before_running_rdoc

      $stderr.puts "rdoc #{args.join ' '}" if Rake.application.options.trace
    end
    RDoc::RDoc.new.document args

    self
  end
end
