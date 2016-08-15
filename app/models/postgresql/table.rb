class PostgreSQL::Table
  include Virtus.model

  attribute :database, PostgreSQL::Database
  attribute :deployment, PostgreSQL::Deployment

  attribute :name, String

  delegate :client, to: :database
  def columns
    client.exec(<<-eos
      SELECT 
        column_name, data_type
      FROM information_schema.columns
      WHERE table_name = '#{name}';
    eos
    ).map { |row| OpenStruct.new name: row['column_name'], datatype: row['data_type'] }
  end
end
