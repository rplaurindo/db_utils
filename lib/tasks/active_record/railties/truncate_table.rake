require "yaml"

namespace :db do
  namespace :truncate do

    desc "Truncate Table"

    task :table, [:table_name, :restart_keys, :cascade] => [:environment] do |t, params|

      active_record = ActiveRecord::Base

      db_config = YAML::load_file('config/database.yml')
      namespace = ENV['RAILS_NAMESPACE']

      env = Rails.env

      conn_conf = (namespace ? db_config[namespace][env] : db_config[env]).clone
      database = db_config[namespace][env]["database"]
      active_record.establish_connection conn_conf
      connection = active_record.connection

      begin
        connection.truncate params[:table_name], restart_keys: params[:restart_keys], cascade: params[:cascade]
      rescue => e
        p e
      else
        p "Tabela #{params[:table_name]} truncada com sucesso."
      end

    end

  end
end
