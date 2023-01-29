require 'pg'
require 'csv'
require "fileutils"
require_relative 'helpers/constants'
require_relative 'helpers/db_connection'

class ImportDictionary
  def self.call
    connection = db_connect
    file_names = [START_FILE,END_FILE].map{|index| "#{FILE_PREFIX}#{index.to_s.rjust(FILE_NAME_ZERO_PADDING, "0")}.#{FILE_EXTENSION}"}

    file_names.each do |file|
      CSV.foreach("#{FILE_PATH}#{file}", headers: true) do |row|
        data = row.to_h

        connection.exec("INSERT INTO dictionaries (english, burmese)
            VALUES ('#{sql_sanitize(data['english'])}','#{sql_sanitize(data['burmese'])}');")

        puts "#{data['burmese']}, #{data['english']}"
      rescue => ex
        puts "#{ex.full_message}"
        next
      end
    end
    connection.close if connection
    puts "Closing database connection for the database : #{@source_db_name}"
  end
end

ImportDictionary.call