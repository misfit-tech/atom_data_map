require "spreadsheet_architect"
require 'csv'
require "fileutils"
require_relative 'constants'
require_relative 'methods'

class ProcessCsv

  def self.create(file_name, headers, data)
    @file_name = "#{File.dirname(__FILE__)}/../csv_directories/#{file_name}"
    @headers = headers
    @data = data

    FileUtils::mkdir_p File.dirname @file_name

    Methods.print_file_length('process_csv.rb', "Data count in xlsx file: #{@file_name}: #{@data.count}")
    return true if @data.count == 0
    Methods.print_log('process_csv.rb', "Starting creating xlsx file: #{@file_name}")

    file_data = SpreadsheetArchitect.to_xlsx(headers: @headers, data: @data)

    File.open(@file_name, 'w+b') do |f|
      f.write file_data
    end

    Methods.print_log('process_csv.rb', "xlsx file: #{@file_name} created")
  rescue => error
    Methods.print_error('process_csv.rb', "Error while creating xlsx file: #{@file_name} :: #{error.message}")
  end
end