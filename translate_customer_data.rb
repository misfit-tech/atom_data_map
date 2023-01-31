require_relative 'tasks/data_map.rb'
require_relative 'helpers/constants'
require_relative 'helpers/methods'

begin
  threads = []
  NUMBER_OF_THREADS.times do |index|
    per_thread = (LIMIT - OFFSET) / NUMBER_OF_THREADS
    start = OFFSET + index * per_thread
    threads << Thread.new do
      DataMap.call(start, start+per_thread)
      sleep(300)
    end
  end
  threads.each(&:join)
  Methods.print_log('data_map.rb.rb', "Both Database connection closed")
rescue => e
  Methods.print_error('translate_customer_data.rb', "Error: #{e.full_message}")

end