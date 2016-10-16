require "yaml"

namespace :db do
  namespace :truncate do

    desc "Truncate Table"

    task :table, [:table_name, :restart_keys, :cascade] => [:environment] do |t, params|

      active_record = ActiveRecord::Base

      db_config = YAML::load_file('config/database.yml')
      namespace = ENV['NAMESPACE']

      env = Rails.env

      connection_config = (namespace ? db_config[namespace][env] : db_config[env]).clone
      database = db_config[namespace][env]["database"]
      active_record.establish_connection connection_config
      connection = active_record.connection

      table_name = params[:table_name].strip
      begin
        connection.truncate table_name, restart_keys: params[:restart_keys], cascade: params[:cascade]
      rescue => e
        $stderr.puts e
      else
        $stderr.puts "Table \"#{table_name}\" has been truncated."
      end

    end

  end
end
