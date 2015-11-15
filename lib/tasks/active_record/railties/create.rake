require "yaml"

namespace :sentinel do
  namespace :db do

    desc "Creates database."

    task :create, [:namespaces] => [:environment] do |t, params|
      extend Sentinel::Engine.helpers

      namespaces = params.extras.unshift params[:namespaces] ? params[:namespaces] : engine_name

      db_config = YAML::load_file('config/database.yml')
      env = Rails.env
      active_record = ActiveRecord::Base

      namespaces.each do |namespace|
        begin
          conn_confs = db_config[namespace][env].clone
          database = db_config[namespace][env]["database"]
          conn_confs["database"] = "postgres"
          active_record.establish_connection conn_confs
          active_record.connection.create_database database
        rescue => e
          $stderr.puts parse_message_error e.message
        # útil para mostrar uma mensagem de sucesso, caso um erro não seja mostrado com o uso do Exception.new, não sendo necessário o uso do throw para interromper o fluxo da execução, caso não haja mais código após o bloco begin..recue..end.
        else
          p "Database #{namespace}_#{env} criado."
        # ensure
          # that this code always runs
        end
      end

      ENVS = ["test", "development"]

      ENVS.each do |env|
        begin
          conn_confs = db_config[env].clone
          database = conn_confs["database"]
          conn_confs["database"] = "postgres"
          active_record.establish_connection conn_confs
          active_record.connection.create_database database
        rescue => e
          $stderr.puts parse_message_error e.message
        else
          p "Database #{database} criado."
        end
      end

    end #endtask

  end
end
