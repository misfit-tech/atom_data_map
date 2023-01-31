require_relative 'constants'
class Methods
  MSISDN_POSSIBLE_REGEX_LIST = %w(\A(09|9|\+?950?9|\+?95950?9)\d{7,9}\z ^(09|\\+?959)9(7|6)\\d{7}$ ^(09|\\+?959)7(9|8|7)\\d{7}$ ^(09|\\+?959)(5\\d{6}|4\\d{7,8}|2\\d{6,8}|3\\d{7,8}|6\\d{6}|8\\d{6}|7\\d{7}|9(0|1|9)\\d{5,6})$ ^0095994[0-9]{7}$ ^0994[0-9]{7}$ ^95994[0-9]{7}$ ^0095998[0-9]{7}$ ^0998[0-9]{7}$ ^95998[0-9]{7}$ ^0095997[0-9]{7}$ ^0997[0-9]{7}$ ^95997[0-9]{7}$ ^0095996[0-9]{7}$ ^0996[0-9]{7}$ ^95996[0-9]{7}$ ^0095995[0-9]{7}$ ^0995[0-9]{7}$ ^95995[0-9]{7}$ ^009597[6789][0-9]{7}$ ^9597[6789][0-9]{7}$ ^097[6789][0-9]{7}$ ^0095975[0123][0-9]{6}$ ^95975[0123][0-9]{6}$ ^0975[0-9][0-9]{6}$ ^009597[4][0-9]{7}$ ^9597[4][0-9]{7}$ ^097[4][0-9]{7}$ ^009596[7-9][0-9]{7}$ ^9596[7-9][0-9]{7}$ ^096[7-9][0-9]{7}$ ^009596[5][0-9]{7}$ ^9596[5][0-9]{7}$ ^096[5][0-9]{7}$ ^0095966[0-6][0-9]{6}$ ^95966[0-6][0-9]{6}$ ^0966[0-6][0-9]{6}$ ^0095966[7-9][0-9]{6}$ ^95966[7-9][0-9]{6}$ ^0966[7-9][0-9]{6}$ ^009592[0-9]{6} ^9592[0-9]{6} ^092[0-9]{6} ^0095925[0-9]{1}[0-9] ^95925[0-9]{1}[0-9] ^0925[0-9]{1}[0-9] ^00959290[0-9]{4} ^959290[0-9]{4} ^09290[0-9]{4} ^0093[0-9]{6} ^9593[0-9]{6} ^093[0-9]{6} ^0095937[0-9]{6} ^95937[0-9]{6} ^0937[0-9]{6} ^0095941[0-9]{6} ^95941[0-9]{6} ^0941[0-9]{6} ^0095942[0-9]{1}[0-9] ^95942[0-9]{1}[0-9] ^0942[0-9]{1}[0-9] ^009594[35]{1}[0-9] ^9594[35]{1}[0-9] ^094[35]{1}[0-9] ^009595[0-6]{1}[0-9] ^9595[0-6]{1}[0-9] ^095[0-6]{1}[0-9] ^0095944[6-9]{1}[0-9] ^95944[6-9]{1}[0-9] ^0944[6-9]{1}[0-9] ^009592[0-4]{1}[0-9] ^9592[0-4]{1}[0-9] ^092[0-4]{1}[0-9] ^0095940[0-9]{1}[0-9] ^95940[0-9]{1}[0-9] ^0940[0-9]{1}[0-9] ^0095944[0-5]{1}[0-9] ^95944[0-5]{1}[0-9] ^0944[0-5]{1}[0-9] ^0095989[6-9][0-9]{6}$ ^95989[6-9][0-9]{6}$ ^0989[6-9][0-9]{6}$ ^0095989[0-5][0-9]{6}$ ^95989[0-5][0-9]{6}$ ^0989[0-5][0-9]{6}$ ^0095926[78][0-9]{6}$ ^95926[78][0-9]{6}$ ^0926[78][0-9]{6}$ ^0095926[789][0-9]{6}$ ^95926[789][0-9]{6}$ ^0926[789][0-9]{6}$ ^0095988[4-9][0-9]{6}$ ^95988[4-9][0-9]{6}$ ^0988[4-9][0-9]{6}$ ^0095988[0-3][0-9]{6}$ ^95988[0-3][0-9]{6}$ ^0988[0-3][0-9]{6}$ )


  def self.process_nrc(nrc)
    splited_nrc = nrc.split('/')

    return nil if splited_nrc.length < 2
    region_code = splited_nrc[0]
    splited_nrc = splited_nrc[1].split('(')

    return nil if splited_nrc.length < 2
    town_ship_code = splited_nrc[0].downcase
    splited_nrc = splited_nrc[1].split(')')

    return nil if splited_nrc.length < 2
    citizenship_type = splited_nrc[0]
    nrc_number = splited_nrc[1]

    {
      region_code: region_code,
      town_ship_code: town_ship_code,
      citizenship_type: citizenship_type,
      nrc_number: nrc_number
    }
  end


  def self.number_map(english_number)
    burmese_word = english_number.length&.times.map do |number|
      BURMESE_NUMBER[number]
    end
    burmese_word.join(',').gsub(/[\s,]/ ,"")
  end


  def self.gender_prefix(name)
    GENDER_PREFIX[name.split(' ')[0]]
  end

  def self.process_msisdn(msisdn)
    number_map(msisdn)
  end

  def is_empty(value)
    value == '' || value.nil?
  end

  def is_english_word?(word)
    !is_empty(word) && !/[a-zA-Z0-9 -._*&(#%@]+$/.match(word).nil?
  end

  def valid_msisdn?(msisdn)
    MSISDN_POSSIBLE_REGEX_LIST.any?{ |regex| !/#{regex}/.match(msisdn).nil? }
  end

  def mfs_mapping(msisdn)
    eval(@redis.fetch_from_cache("MFS_#{msisdn}").to_s)
  end

  def process_msisdn(msisdn)
    msisdn.to_s.scan(/\d/).join('').to_i.to_s
  end

  def duplicate_msisdn?(msisdn)
    !@redis.fetch_from_cache("MSISDN_#{msisdn}").nil?
  end

  def deleted_msisdn?(msisdn)
    !@redis.fetch_from_cache("deleted_msisdn_#{msisdn}").nil?
  end

  def duplicate_poi?(poi)
    value = @redis.fetch_from_cache("POI_#{poi}")
    [!value.nil?, eval(value.to_s)]
  end

  def get_id_type(primary_poi_type, id_number)
    if primary_poi_type == 'NRC'
      [0, true, 'nrc']
    elsif old_nrc?(id_number)
      [6, true, 'old_nrc']
    elsif primary_poi_type == 'Driver License'
      [2, false, 'driving_license']
    elsif myanmar_passport?(id_number)
      [1, false, 'myanmar_passport']
    elsif passport?(id_number)
      [1, true, 'passport']
    else
      [6, false, 'others']
    end
  end

  def self.passport?(id_number)
    !/^(?!^0+$)[a-zA-Z]+[a-zA-Z0-9]{3,20}$/.match(id_number).nil? && !/\d/.match(id_number).nil?
  end

  def myanmar_passport?(id_number)
    !/^(?!^0+$)(M)[a-zA-Z0-9]{3,20}$/.match(id_number).nil? && !/\d/.match(id_number).nil?
  end
  def self.old_nrc?(id_number)
    !/^[A-Z\/.-]{3,9}[0-9]{5,6}$/.match(id_number).nil?
  end

  def set_require_kyc_info_upgrade(data)
    [data['primary_poi_type'], data['primary_poi_no'], data['address'],
     data['selfie_photo'], data['gender'], data['dob'], data['name']].any?{ |i| i.to_s == '' }
  end

  def build_nrc_format(prefix, township, nationality, number)
    "#{prefix}/#{township}(#{nationality})#{number}"
  end

  def self.print_log(file, message)
    puts "[INFO] :: [#{Time.now}] :: #{file} :: #{message}"
  end

  def self.print_error(file, message)
    puts "[ERROR] :: [#{Time.now}] :: #{file} :: #{message}"
  end

  def self.print_db(file, message)
    puts "[DB] :: [#{Time.now}] :: #{file} :: #{message}"
  end

  def self.print_file_length(file, message)
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: #{message}"
  end

  def self.print_summary(file, batch, total)
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: ----------------------------------------------------"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: ****************************************************"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: ----------------------------------------------------"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: Printing summary report for #{batch}"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: Total fetched #{total}"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: ----------------------------------------------------"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: ****************************************************"
    puts "[SUMMARY] :: [#{Time.now}] :: #{file} :: ----------------------------------------------------"
  end
end