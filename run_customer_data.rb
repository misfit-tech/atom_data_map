require_relative 'helpers/constants'
require_relative 'tasks/import_customers'

begin
  thread_files = Array.new(NUMBER_OF_THREADS){Array.new}
  file_index = START_FILE
  thread_index = 0
  threads = Array.new

  while file_index <= END_FILE do
    threads[thread_index] << file_index
    file_index += 1
    thread_index += 1
    thread_index = thread_index % NUMBER_OF_THREADS
  end

  puts thread_files.inspect
  thread_files.each do |file_numbers|
    files_paths = file_numbers.map{|number| "#{FILE_PREFIX}#{number.to_s.rjust(FILE_NAME_ZERO_PADDING, "0")}.#{FILE_EXTENSION}"}
    threads << Thread.new do
      ImportCustomers.call(files_paths)
      sleep(300)
    end
  end

  threads.each(&:join)
rescue => e
  puts "Error: #{e.full_message}"
end
