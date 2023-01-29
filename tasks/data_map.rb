require 'pg'
require 'csv'
require "fileutils"
require_relative 'helpers/constants'

class DataMap
  def self.call(index = 0, limit = 1, offset = 0)

  @host = String('localhost'),
  @source_db_name = String('atom'),
  @source_db_user = String('misfit'),
  @source_db_password = String('password'),
  @port = String('5432')
  @subcriber_table_name = String('dictionaries')
  @file_path = String('~/atom_data_map/csv_directories/')

  connection = PG::Connection.new(:host => 'localhost', :user => @source_db_user, :dbname => @source_db_name, :port => @port, :password => @source_db_password)
  puts "Successfully created connection to #{@host} : #{@source_db_name} database"

  files = Dir["#{@file_path}/*"]

    files.each do |file|
      CSV.foreach(file, :headers => true) do |row|
        data = row.to_h
        next if data['name'].nil?

        splited_words = data['name'].strip.split(' ')
        name_array = splited_words.reject(&:empty?)
        is_missing = false
        result_array = name_array.map do |name_part|
          result = connection.exec("SELECT dictionaries.id AS id, dictionaries.english AS english_world, dictionaries.burmese AS burmese_word
                                  FROM dictionaries
                                  WHERE dictionaries.english_word = '#{name_part}' AND word_type = 3
                                  limit #{limit};")
          if result.count == 0
            is_missing = true
            connection.exec("INSERT INTO missing_words (english_word)
          VALUES ('#{name_part}');")
            ''
          else
            result[0]['burmese_word']
          end
        end
        connection.exec("INSERT INTO customers (customer_name, translated_name, is_missing)
              VALUES ('#{data['CUSTOMER_NAME']}', '#{result_array.join(' ')}', #{is_missing});")
      end
    end
    connection.close if connection
    puts "Closing database connection for the database : #{@source_db_name}"
  end
end

DataMap.call