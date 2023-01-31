require 'pg'
require 'csv'
require "fileutils"
require_relative '../helpers/db_connection'

class ImportDictionary
  def self.call
    connection = db_connect

      CSV.foreach("#{File.dirname(__FILE__)}/../csv_directories/dictionary_1.csv", headers: true) do |row|
        data = row.to_h
        result = connection.exec("SELECT * FROM dictionaries WHERE dictionaries.english = '#{data['english']}' limit 1;")

        if result.count == 0
          connection.exec("INSERT INTO dictionaries (english, burmese)
            VALUES ('#{sql_sanitize(data['english'])}','#{sql_sanitize(data['burmese'])}');")
          puts "english : #{sql_sanitize(data['english'])} | burmese: #{sql_sanitize(data['burmese'])} | ACTION: Insert"
        else
          connection.exec("UPDATE dictionaries SET burmese = '#{data['burmese']}'
            WHERE english = '#{sql_sanitize(result[0]['english'])}';")
          puts "english : #{sql_sanitize(data['english'])} | burmese: #{sql_sanitize(data['burmese'])} | ACTION: Update"
        end
      rescue => ex
        puts "#{ex.full_message}"
        next
      end
    connection.close if connection
    puts "Closing database connection for the database"
  end
end

ImportDictionary.call