require 'pg'
require 'csv'
require "fileutils"
require_relative '../helpers/db_connection'

class ImportCustomers
  def self.call(files_paths)
    connection = db_connect

    files_paths.each do |file_path|
      CSV.foreach(file_path, headers: true, col_sep: '|') do |row|
        data = row.to_h

        result = connection.exec("SELECT * FROM customers WHERE customers.nrc = '#{data['NRC']}' limit 1;")

        if result.count == 0
          connection.exec("INSERT INTO customers (sr_num, name, msisdn1, nrc)
            VALUES (#{data['SR_NUM']}, '#{sql_sanitize(data['NAME'])}', #{data['MSISDN']}, '#{data['NRC']}');")
          puts "NRC : #{data['NRC']} | MSISDN1: #{data['MSISDN']} | ACTION: Insert"

        else
          unless result[0]['msisdn2'].nil?
            puts "NRC : #{data['NRC']} | MSISDN: #{data['MSISDN']}  | ACTION: Skip"
            next
          end

          connection.exec("UPDATE customers SET msisdn2 = #{data['MSISDN']}'
            WHERE id = #{result[0]['id']};")
          puts "NRC : #{data['NRC']} | MSISDN2: #{data['MSISDN']} | ACTION: Update"
        end
      end
    end
    connection.close if connection
  end
end
