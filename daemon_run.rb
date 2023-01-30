require 'daemons'

Daemons.run('translate_customer_data.rb', log_output: true)
