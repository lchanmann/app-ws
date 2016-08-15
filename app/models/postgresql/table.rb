class PostgreSQL::Table
  include Virtus.model

  attribute :database, PostgreSQL::Database
  attribute :deployment, PostgreSQL::Deployment

  attribute :name, String
  attribute :schema, String
  attribute :rows_count, Integer

  delegate :client, to: :database

  def columns
    result = client.exec(<<-eos
      SELECT 
        column_name, data_type
      FROM information_schema.columns
      WHERE 
        table_name = '#{sanitized_name}' AND
        table_schema = '#{sanitized_schema}';
    eos
    )
    raise Errors::NotFound, "Table not found." if result.count == 0
    result.map { |row| OpenStruct.new name: row['column_name'], datatype: row['data_type'] }
  end

  def data
    result = client.exec(<<-eos
      SELECT * FROM "#{sanitized_schema}"."#{sanitized_name}";
    eos
    )
  end

  #
  # Dynamically defined methods
  #
  def method_missing method, *args, &block
    # sanitized_{attribute}
    if method =~ /^sanitized_(\w+)$/
      raise NoMethodError, "undefined attribute `#{$1}' for #{self.class}" \
        unless attributes.keys.include? $1.to_sym

      # TODO: can also raise here when the attribute is not a String
      send($1).try(:gsub, "'", "''")
    else
      super
    end
  end
end
