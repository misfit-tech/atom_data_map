require_relative 'tasks/data_map.rb'
require_relative 'helpers/constants'

begin
  threads = []
  (START_BATCH..END_BATCH.to_i).each do |index|
    current_offset = OFFSET + (index - 1) * LIMIT
    threads << Thread.new do
      DataMap.call(index, LIMIT, current_offset)
      sleep(300)
    end
  end
  threads.each(&:join)
rescue => e
  Methods.print_error('translate_customer_data.rb', "Error: #{e.full_message}")
end