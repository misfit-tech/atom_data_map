require_relative 'tasks/data_map.rb'
require_relative 'helpers/constants'
require_relative 'helpers/methods'

begin
  connection = db_connect
  threads = []
  (START_BATCH..END_BATCH.to_i).each do |index|
    current_offset = OFFSET + (index - 1) * LIMIT
    threads << Thread.new do
      DataMap.call(index, LIMIT, current_offset, connection)
      sleep(300)
    end
  end
  threads.each(&:join)
  connection.close if connection
  Methods.print_log('data_map.rb.rb', "Both Database connection closed")
rescue => e
  Methods.print_error('translate_customer_data.rb', "Error: #{e.full_message}")
end