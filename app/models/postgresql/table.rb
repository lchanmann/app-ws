class PostgreSQL::Table
  include Virtus.model

  attribute :database, PostgreSQL::Database
  attribute :deployment, PostgreSQL::Deployment

  attribute :name, String
  attribute :schema, String

  delegate :client, to: :database

  def columns
    result = client.exec(<<-eos
      SELECT 
        column_name, data_type
      FROM information_schema.columns
      WHERE 
        table_name = '#{sanitized_name}' AND
        table_schema = '#{schema}';
    eos
    )
    raise Errors::NotFound, "Table not found." if result.count == 0
    result.map { |row| OpenStruct.new name: row['column_name'], datatype: row['data_type'] }
  end

  private
    def sanitized_name
      name.gsub "'", "''"
    end
end
