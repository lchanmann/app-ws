class PostgreSQL::Deployment < Deployment
  
  def client(db_name = 'postgres')
    PG::Connection.new({
      host: host,
      port: port,
      user: username,
      password: password,
      dbname: db_name
    })
  rescue PG::ConnectionBad
    raise Errors::NotFound, "Database not found."
  end

  def databases
    client.exec(<<-eos
      SELECT pg_database.datname
      FROM pg_database
      WHERE datistemplate = false;
    eos
    ).select {|row| row['datname'] != 'postgres'}.map do |row|
      PostgreSQL::Database.new(name: row['datname'], deployment: self)
    end
  end

  def current_queries
    client.exec(<<-eos
      SELECT 
        pid, query
      FROM pg_stat_activity
      WHERE query NOT LIKE '%FROM pg_stat_activity%'
      ORDER BY pid DESC;
    eos
    ).map { |row| OpenStruct.new row }
  end

end
