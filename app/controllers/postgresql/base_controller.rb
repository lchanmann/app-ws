class PostgreSQL::BaseController < ApplicationController

  helper_method :current_database, :current_table

  def current_database
    return nil unless params[:database_name]
    PostgreSQL::Database.new(name: params[:database_name] || params[:name], deployment: current_deployment)
  end

  def current_table
    return nil unless params[:table_name]
    PostgreSQL::Table.new(name: params[:table_name], schema: params[:schema] || "public", database: current_database, deployment: current_deployment)
  end

end
