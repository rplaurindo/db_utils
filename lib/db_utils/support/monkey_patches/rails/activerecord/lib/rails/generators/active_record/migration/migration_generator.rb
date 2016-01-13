# module ActiveRecord
#   module Generators # :nodoc:
#     class MigrationGenerator < Base # :nodoc:

#       # changed
#       def create_migration_file
#         set_local_assigns!
#         validate_file_name!
#         migration_template @migration_template, resolve_path
#       end

#       private
#         # added
#         def resolve_path
#           path = "db/migrate"
#           if ENV['RAILS_NAMESPACE']
#             path += "/#{ENV['RAILS_NAMESPACE']}"
#           end
#           "#{path}/#{file_name}.rb"
#         end

#     end
#   end
# end
