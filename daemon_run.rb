require 'daemons'

Daemons.run('run_customer_data.rb', log_output: true)
