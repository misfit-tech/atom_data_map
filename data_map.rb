require 'pg'
require 'csv'
require "fileutils"
require 'json'

class DataMap
  def self.call(limit, offset)

  @host = String('localhost'),
  @source_db_name = String('atom'),
  @source_db_user = String('misfit'),
  @source_db_password = String('password'),
  @port = String('5432')
  @subcriber_table_name = String('dictionaries')
  @file_path = String('/Users/arif/development/atom/CSV_DIRECTORIES/')

  connection = PG::Connection.new(:host => 'localhost', :user => @source_db_user, :dbname => @source_db_name, :port => @port, :password => @source_db_password)
  puts "Successfully created connection to #{@host}:#{@source_db_name} database"

  files = Dir["#{@file_path}/*"]

  files.each do |file|
    CSV.foreach(file, :headers => true) do |row|
      data = row.to_h
      next if data['CUSTOMER_NAME'].nil?

      splited_words = data['CUSTOMER_NAME'].strip.split(' ')
      name_array = splited_words.reject(&:empty?)
      is_missing = false
      result_array = name_array.map do |name_part|
        result = connection.exec("SELECT dictionaries.id AS id, dictionaries.english_word AS english_word, dictionaries.burmese_word AS burmese_word
                                  FROM dictionaries
                                  WHERE dictionaries.english_word = '#{name_part}' AND word_type = 3
                                  limit #{1} offset #{offset};")

        if result.to_h.nil? || result.to_h.count.zero?
          is_missing = true
          connection.exec("INSERT INTO missing_words (english_word)
          VALUES ('#{name_part}');")
        elsif
          result.to_h['burmese_word']
        else
          name_part
        end
      end

      rest_result = result_array.length.zero? ? ' ' : result_array.map{|r| r.to_h['burmese_word'].nil? ? ' ': r.to_h['burmese_word']}
      connection.exec("INSERT INTO customers (customer_name, translated_name, is_missing)
              VALUES ('#{data['CUSTOMER_NAME']}', '#{rest_result.join(' ')}', #{is_missing});")
    end
  end
  connection.close if connection
  puts "Closing database connection for the database : #{@source_db_name}"

  end
end

DataMap.call(5, 1)