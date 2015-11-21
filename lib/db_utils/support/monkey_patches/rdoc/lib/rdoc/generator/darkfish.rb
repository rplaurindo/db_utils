require "rdoc/task"

class RDoc::Generator::Darkfish

  def generate_page file
    setup

    template_file = @template_dir + 'page.rhtml'

    out_file = @outputdir + File.basename(file.path)
    debug_msg "  working on %s (%s)" % [file.full_name, out_file]
    rel_prefix = @outputdir.relative_path_from out_file.dirname
    search_index_rel_prefix = rel_prefix
    search_index_rel_prefix += @asset_rel_path if @file_output

    # suppress 1.9.3 warning
    current          = current          = file
    asset_rel_prefix = asset_rel_prefix = rel_prefix + @asset_rel_path

    @title = "#{file.page_name} - #{@options.title}"

    debug_msg "  rendering #{out_file}"
    render_template template_file, out_file do |io| binding end
  end

end
