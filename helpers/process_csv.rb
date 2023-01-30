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

    Methods.print_file_length('process_csv.rb', "Data count in CSV file: #{@file_name}: #{@data.count}")
    return true if @data.count == 0
    Methods.print_log('process_csv.rb', "Starting creating CSV file: #{@file_name}")
    CSV.open(@file_name, 'w', write_headers: true, headers: @headers) do  |writer|
      @data.each do |data|
        begin
          writer << data
        rescue => ex
          Methods.print_error('process_csv.rb', "Error while writing data: #{data} in CSV file: #{@file_name} :: #{ex.message}")
        end
      end
    end

    Methods.print_log('process_csv.rb', "CSV file: #{@file_name} created")
  rescue => error
    Methods.print_error('process_csv.rb', "Error while creating CSV file: #{@file_name} :: #{error.message}")
  end
end