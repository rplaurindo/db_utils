module TableMappingHelper
  module Rails
    module Mapper

      extend self

      def set_table constant
        if parent(constant) != ActiveRecord
          constant.table_name = resolve_constant_name constant
        end
      end

      class << self

        private
          # called only once by module or class that include it
          def included constant
            set_table constant
          end

      end

      private

        def parent constant
          parent_name = constant.name.deconstantize
          parent_name.constantize unless parent_name.empty?
        end

        def resolve_constant_name constant
          "#{parent(constant).name.underscore}_#{constant.name.demodulize.underscore.pluralize}"
        end

    end
  end
end
