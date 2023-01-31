require 'pg'
require_relative "../helpers/db_connection"
require_relative '../helpers/methods'
require_relative '../helpers/process_csv'
require_relative '../helpers/constants'

class DataMap
  def self.call(offset, limit)
    connection = db_connect
    # source DB connection
    Methods.print_db('data_map.rb', "Batch start with #{offset}-#{limit}")

    page_offset = offset
    while page_offset < limit do
      result_set = connection.exec("SELECT * FROM customer_data
                                order by customer_data.sr_num limit #{PER_PAGE} offset #{page_offset};")
      page_offset += PER_PAGE


    return nil if result_set.nil? || result_set.count.zero?

    Methods.print_log('data_map.rb.rb', "Start page processing batch: start with #{page_offset} and size #{result_set.count}")

    translation_data_headers = %w[စဉ် တိုင်း/ပြည်နယ်Code မြို့နယ်Code အမျိုးအစား မှတ်ပုံတင်အမှတ် ကျား/မ အမည် ဖုန်းနံပါတ်(၁) ဖုန်းနံပါတ်(၂)]
    old_nrc_headers = ["nrc"]
    missing_words_headers = ["name"]

    translation_data = []
    old_nrc = []
    missing_words = []

    result_set.each_with_index do |row, serial_no|
      data = Hash.new
      processed_nrc = Methods.process_nrc(row['nrc'])

      data['nrc'] = row['nrc']

      if processed_nrc.nil?
        old_nrc << [data['nrc']]
        next
      end

      data['စဉ်'] =  Methods.number_map(page_offset + serial_no)
      data['တိုင်း/ပြည်နယ်Code'] = REGION_CODE[processed_nrc[:region_code]]
      data['မြို့နယ်Code'] = TOWN_SHIP_CODE[processed_nrc[:town_ship_code]]
      data['အမျိုးအစား'] = CITIZENSHIP_TYPE[processed_nrc[:citizenship_type]]
      data['မှတ်ပုံတင်အမှတ်'] = Methods.number_map(processed_nrc[:nrc_number])
      data['ကျား/မ'] = Methods.gender_prefix(row['name'])
      data['အမည်'] = translate_to_burmese(Methods.remove_prefix_from_name(row['name']), missing_words, connection)
      data['ဖုန်းနံပါတ်(၁)'] = row['msisdn'][0] == '9' ? row['msisdn']&.to_s&.delete_prefix!('9') : row['msisdn']
      data['ဖုန်းနံပါတ်(၂)'] = ''
      
      translation_data << [data['စဉ်'],data['တိုင်း/ပြည်နယ်Code'],data['မြို့နယ်Code'],data['အမျိုးအစား'],data['မှတ်ပုံတင်အမှတ်'],data['ကျား/မ'],data['အမည်'],data['ဖုန်းနံပါတ်(၁)'],data['ဖုန်းနံပါတ်(၂)']]
    end

      Methods.print_summary('data_map.rb.rb', "BATCH##{page_offset}", result_set.count)

      ProcessCsv.create("non_nrc/Batch#{(page_offset/PER_PAGE).to_i}.xlsx", old_nrc_headers, old_nrc)
      ProcessCsv.create("nrc/Batch#{(page_offset/PER_PAGE).to_i}.xlsx", translation_data_headers, translation_data)
      ProcessCsv.create("missing_words/Batch#{(page_offset/PER_PAGE).to_i}.xlsx", missing_words_headers, missing_words)

    end
    connection.close if connection
  rescue PG::Error => e
    Methods.print_error('data_map.rb.rb', "Database error due to: #{e.full_message}")
  end

  def self.translate_to_burmese(name, missing_words, connection)
    return '' if name.nil?

    splited_words = name.strip.split(' ')
    name_array = splited_words.reject(&:empty?)
    result_array = name_array.map do |name_part|
      result = connection.exec("SELECT *
                                FROM dictionaries
                                WHERE LOWER(dictionaries.english) = '#{sql_sanitize(name_part).downcase}'
                                limit 1;")
      if result.count == 0
        connection.exec("INSERT INTO missing_words (english)
          VALUES ('#{name_part}');")
        missing_words << [name_part]
        name_part
      else
        result[0]['burmese']
      end
    end
    result_array.join(' ')
  end
end