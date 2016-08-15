class PostgreSQL::TablesController < PostgreSQL::BaseController

  def index
    render locals: {tables: current_database.tables}
  end

  def show
    render locals: {columns: current_table.columns}
  end

  def data
    render locals: {data: current_table.data}
  end

end
