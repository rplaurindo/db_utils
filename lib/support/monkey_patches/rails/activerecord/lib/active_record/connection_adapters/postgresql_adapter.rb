module ActiveRecord
  module ConnectionAdapters

    class PostgreSQLAdapter < AbstractAdapter

      def truncate table_name, params = {}, name = nil
        query = "TRUNCATE TABLE #{quote_table_name(table_name)}"
        query = "#{query} RESTART IDENTITY" if params[:restart_identity]
        query = "#{query} CASCADE" if params[:cascade]

        exec_query query, name, []
      end

    end

  end

  class Base

    class << self

      def has_connection?
        begin
          ActiveRecord::Base.connection
        rescue ActiveRecord::NoDatabaseError
          false
        else
          true
        end
      end

    end

  end

end
