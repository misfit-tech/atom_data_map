require 'pg'
require_relative "../helpers/db_connection"
require_relative '../helpers/methods'
require_relative '../helpers/process_csv'
require_relative '../helpers/constants'

class DataMap
  def self.call(index, limit, offset, connection)
    # source DB connection
    Methods.print_db('data_map.rb', "Trying to open database connection for Batch#{index}")

    resultSet = connection.exec("SELECT * FROM customer_data
                                order by customer_data.sr_num desc limit #{limit} offset #{offset};")

    return nil if resultSet.nil? || resultSet.count.zero?
    connection.close if connection

    Methods.print_db('data_map.rb.rb', "Closing database connection for Batch#{index}")
    Methods.print_log('data_map.rb.rb', "Start processing batch: #{index}, size: #{resultSet.count}")

    translation_data_headers = %w[စဉ် တိုင်း/ပြည်နယ်Code မြို့နယ်Code အမျိုးအစား မှတ်ပုံတင်အမှတ် ကျား/မ အမည် ဖုန်းနံပါတ်(၁) ဖုန်းနံပါတ်(၂)]
    old_nrc_headers = ["nrc"]
    passport_headers = ["password"]
    missing_words_headers = ["name"]

    translation_data = []
    old_nrc = []
    passports = []
    missing_words = []

    resultSet.each_with_index(1) do |row, serial_no|
      data = {}
      processed_nrc = Methods.process_nrc(row['nrc'])

      data['nrc'] = row['nrc']

      if Methods.old_nrc?(processed_nrc[:nrc_number])
        old_nrc << [data['nrc']]
        next
      end

      if Methods.passport?(processed_nrc[:nrc_number])
        passports << [data['nrc']]
        next
      end

      data['စဉ်'] = serial_no
      data['တိုင်း/ပြည်နယ်Code'] = REGION_CODE[processed_nrc[:region_code]]
      data['မြို့နယ်Code'] = TOWN_SHIP_CODE[processed_nrc[:town_ship_code]]
      data['အမျိုးအစား'] = CITIZENSHIP_TYPE[processed_nrc[:citizenship_type]]
      data['မှတ်ပုံတင်အမှတ်'] = Methods.number_map(processed_nrc[:nrc_number])
      data['ကျား/မ'] = Methods.gender_prefix(row['name'])
      data['အမည်'] = translate_to_burmese(row['name'], missing_words)
      data['ဖုန်းနံပါတ်(၁)'] = Methods.process_msisdn(row['msisdn'].split(',')[0])
      data['ဖုန်းနံပါတ်(၂)'] = Methods.process_msisdn(row['msisdn'].split(',')[1])
      data['name'] = row['name']

      translation_data << [data['စဉ်'],data['တိုင်း/ပြည်နယ်Code'],data['မြို့နယ်Code'],data['အမျိုးအစား'],data['မှတ်ပုံတင်အမှတ်'],data['ကျား/မ'],data['အမည်'],data['ဖုန်းနံပါတ်(၁)'],data['ဖုန်းနံပါတ်(၂)'] ]
    end

    Methods.print_summary('data_map.rb.rb', "BATCH##{index}", resultSet.count)

    ProcessCsv.create("Batch#{index}/old_nrc.csv", old_nrc_headers, old_nrc)
    ProcessCsv.create("Batch#{index}/passport.csv", passport_headers, passports)
    ProcessCsv.create("Batch#{index}/translated_data.csv", translation_data_headers, translation_data)
    ProcessCsv.create("Batch#{index}/missing_words.csv", missing_words_headers, missing_words)

  rescue PG::Error => e
    Methods.print_error('data_map.rb.rb', "Database error due to: #{e.full_message}")
  end

  def self.translate_to_burmese(name, missing_words)
    return '' if name.nil?

    splited_words = name.strip.split(' ')
    name_array = splited_words.reject(&:empty?)
    result_array = name_array.map do |name_part|
      result = connection.exec("SELECT *
                                FROM dictionaries
                                WHERE dictionaries.english_word = '#{name_part}' AND word_type = 3
                                limit 1;")
      if result.count == 0
        connection.exec("INSERT INTO missing_words (english)
          VALUES ('#{name_part}');")
        missing_words << result[0]['english']
        result[0]['english']
      else
        result[0]['burmese']
      end
    end
    result_array.join(' ')
  end
end