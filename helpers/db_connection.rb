def db_connect
  PG::Connection.new(
    host: 'localhost',
    user: 'misfit',
    dbname: 'atom',
    port: '5432',
    password: 'password'
  )
end

def sql_sanitize(data)
  data&.sub("'", "''")
end
