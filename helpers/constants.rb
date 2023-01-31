# LIMIT = 1000000
# OFFSET = 0
FILE_PREFIX='CustomerData_'
FILE_EXTENSION='csv'
START_FILE=2
END_FILE=12
FILE_NAME_ZERO_PADDING=2
FILE_PATH = '~/atom_data_map/csv_directories/'
NUMBER_OF_THREADS=5
LIMIT = 1000
OFFSET = 0
PER_PAGE=100


GENDER_PREFIX = {
  'U' => 'ဦး',
  'Ma' => 'မ',
  'Mg' => 'မောင်',
  'Maung' => 'မောင်',
  'Daw' => 'ဒေါ်'
}

REGION_CODE =  {
  '1' => 'ကချင်_၁',
  '2' => 'ကယား_၂',
  '3' => 'ကရင်_၃',
  '4' => 'ချင်း_၄',
  '5' => 'စစ်ကိုင်း_၅',
  '6' => 'တနင်္သာရီ_၆',
  '7' => 'ပဲခူး_၇',
  '8' => 'မကွေး_၈',
  '9' => 'မန္တလေး_၉',
  '10' => 'မွန်_၁၀',
  '11' => 'ရခိုင်_၁၁',
  '12' => 'ရန်ကုန်_၁၂',
  '13' => 'ရှမ်း_၁၃',
  '14' => 'ဧရာဝတီ_၁၄'
}

CITIZENSHIP_TYPE = {
  'P' => 'ပြု',
  'N' => 'နိုင်',
  'E' => 'ဧည့်',
  'T' => 'သ',
  'AhMaTa' => 'အမတ',
  'S' => 'စီ',
  'FRC' => 'FRC'
}

BURMESE_NUMBER = {
  0 => '၀',
  1 => '၁',
  2 => '၂',
  3 => '၃',
  4 => '၄',
  5 => '၅',
  6 => '၆',
  7 => '၇',
  8 => '၈',
  9 => '၉'
}

TOWN_SHIP_CODE = {
  'bamana'=> 'ဗမန',
  'khahpana'=> 'ခဖန',
  'dahpaya'=> 'ဒဖယ',
  'hapana'=> 'ဟပန',
  'hpakana'=> 'ဖကန',
  'ahgaya'=> 'အကယ',
  'kamana'=> 'ကမန',
  'kamata'=> 'ကမတ',
  'kapata'=> 'ကပတ',
  'khalahpa'=> 'ခလဖ',
  'lagana'=> 'လဂန',
  'makhaba'=> 'မခဘ',
  'masana'=> 'မဆန',
  'makata'=> 'မကတ',
  'manyana'=> 'မညန',
  'mamana'=> 'မမန',
  'makana'=> 'မကန',
  'malana'=> 'မလန',
  'namana'=> 'နမန',
  'pawana'=> 'ပဝန',
  'panada'=> 'ပနဒ',
  'pataah'=> 'ပတအ',
  'sadana'=> 'ဆဒန',
  'yabaya'=> 'ရဗယ',
  'yakana'=> 'ရကန',
  'sabana'=> 'ဆဘန',
  'sapaba'=> 'ဆပဘ',
  'sapaya'=> 'ဆပရ',
  'tanana'=> 'တနန',
  'salana'=> 'စလန',
  'tasala'=> 'တဆလ',
  'wamana'=> 'ဝမန',
  'balakha'=> 'ဘလခ',
  'damasa'=> 'ဒမဆ',
  'hpasana'=> 'ဖဆန',
  'hpayasa'=> 'ဖရဆ',
  'lakana'=> 'လကန',
  'yatana'=> 'ရတန',
  'yathana'=> 'ရသန',
  'bagala'=> 'ဘဂလ',
  'labana'=> 'လဘန',
  'baahna'=> 'ဘအန',
  'hpapana'=> 'ဖပန',
  'bathasa'=> 'ဘသဆ',
  'kamama'=> 'ကမမ',
  'kakaya'=> 'ကကရ',
  'kadana'=> 'ကဒန',
  'kasaka'=> 'ကဆက',
  'kadata'=> 'ကဒတ',
  'lathana'=> 'လသန',
  'mawata'=> 'မဝတ',
  'pakana'=> 'ပကန',
  'yayatha'=> 'ရရသ',
  'sakala'=> 'စကလ',
  'thatana'=> 'သတန',
  'thataka'=> 'သတက',
  'walama'=> 'ဝလမ',
  'kakhana'=> 'ကခန',
  'hpalana'=> 'ဖလန',
  'hakhana'=> 'ဟခန',
  'kapala'=> 'ကပလ',
  'matapa'=> 'မတပ',
  'matana'=> 'မတန',
  'palawa'=> 'ပလဝ',
  'yazana'=> 'ရဇန',
  'yakhada'=> 'ရခဒ',
  'samana'=> 'ဆမန',
  'tatana'=> 'တတန',
  'htatala'=> 'ထတလ',
  'tazana'=> 'တဇန',
  'ahyata'=> 'အရတ',
  'batala'=> 'ဘတလ',
  'khaouta'=> 'ခဥတ',
  'khatana'=> 'ခတန',
  'hamala'=> 'ဟမလ',
  'ahtana'=> 'အတန',
  'kalahta'=> 'ကလထ',
  'kalawa'=> 'ကလဝ',
  'kabala'=> 'ကဘလ',
  'kanana'=> 'ကနန',
  'kathana'=> 'ကသန',
  'kalata'=> 'ကလတ',
  'khaouna'=> 'ခဥန',
  'kalana'=> 'ကလန',
  'lahana'=> 'လဟန',
  'layana'=> 'လရန',
  'mayana'=> 'မယန',
  'mamata'=> 'မမတ',
  'nayana'=> 'နယန',
  'ngazana'=> 'ငဇန',
  'palana'=> 'ပလန',
  'palaba'=> 'ပလဘ',
  'sakana'=> 'ဆကန',
  'salaka'=> 'ဆလက',
  'yabana'=> 'ရဗန',
  'dapaya'=> 'ဒပယ',
  'tamana'=> 'တမန',
  'tasana'=> 'တဆန',
  'htakhana'=> 'ထခန',
  'walana'=> 'ဝလန',
  'wathana'=> 'ဝသန',
  'yaouna'=> 'ရဥန',
  'yamapa'=> 'ယမပ',
  'khapana'=> 'ခပန',
  'bapana'=> 'ဘပန',
  'htawana'=> 'ထဝန',
  'kalaah'=> 'ကလအ',
  'kasana'=> 'ကဆန',
  'lalana'=> 'လလန',
  'tathaya'=> 'တသရ',
  'thayakha'=> 'သရခ',
  'yahpana'=> 'ရဖန',
  'khamana'=> 'ခမန',
  'palata'=> 'ပလတ',
  'maahya'=> 'မအရ',
  'kayaya'=> 'ကရရ',
  'daouna'=> 'ဒဥန',
  'kapaka'=> 'ကပက',
  'kawana'=> 'ကဝန',
  'kakana'=> 'ကကန',
  'katakha'=> 'ကတခ',
  'lapata'=> 'လပတ',
  'natala'=> 'နတလ',
  'nyalapa'=> 'ညလပ',
  'ahhpana'=> 'အဖန',
  'patana'=> 'ပတန',
  'pakhata'=> 'ပခတ',
  'pakhana'=> 'ပခန',
  'patata'=> 'ပတတ',
  'panaka'=> 'ပဏက',
  'hpamana'=> 'ဖမန',
  'pamana'=> 'ပမန',
  'htatapa'=> 'ထတပ',
  'tangana'=> 'တငန',
  'thanapa'=> 'သနပ',
  'thawata'=> 'သဝတ',
  'thakana'=> 'သကန',
  'thasana'=> 'သစန',
  'yataya'=> 'ရတရ',
  'zakana'=> 'ဇကန',
  'patasa'=> 'ပတဆ',
  'ahlana'=> 'အလန',
  'gagana'=> 'ဂဂန',
  'mabana'=> 'မဗန',
  'mahtana'=> 'မထန',
  'mathana'=> 'မသန',
  'ngahpana'=> 'ငဖန',
  'pakhaka'=> 'ပခက',
  'pahpana'=> 'ပဖန',
  'sahpana'=> 'ဆဖန',
  'sataya'=> 'စတရ',
  'sapawa'=> 'ဆပဝ',
  'tataka'=> 'တတက',
  'thayana'=> 'သရန',
  'htalana'=> 'ထလန',
  'yanakha'=> 'ရနခ',
  'yasaka'=> 'ရစက',
  'kahtana'=> 'ကထန',
  'ahmaya'=> 'အမရ',
  'ahmaza'=> 'အမဇ',
  'khaahza'=> 'ခအဇ',
  'khamasa'=> 'ခမစ',
  'mataya'=> 'မတရ',
  'mahama'=> 'မဟမ',
  'mayama'=> 'မရမ',
  'mayata'=> 'မရတ',
  'manama'=> 'မနမ',
  'manata'=> 'မနတ',
  'mahtala'=> 'မထလ',
  'makhana'=> 'မခန',
  'nahtaka'=> 'နထက',
  'ngathaya'=> 'ငသယ',
  'nyaouna'=> 'ညဥန',
  'pathaka'=> 'ပသက',
  'pabana'=> 'ပဘန',
  'pakakha'=> 'ပကခ',
  'paoula'=> 'ပဥလ',
  'sakata'=> 'စကတ',
  'thapaka'=> 'သပက',
  'tataou'=> 'တတဥ',
  'tathana'=> 'တသန',
  'watana'=> 'ဝတန',
  'yamatha'=> 'ရမသ',
  'takana'=> 'တကန',
  'takata'=> 'တကတ',
  'dakhatha'=> 'ဒခသ',
  'lawana'=> 'လဝန',
  'outatha'=> 'ဥတသ',
  'pabatha'=> 'ပဗသ',
  'zabatha'=> 'ဇဗသ',
  'zayatha'=> 'ဇယသ',
  'balana'=> 'ဘလန',
  'khasana'=> 'ခဆန',
  'khazana'=> 'ခဇန',
  'kamaya'=> 'ကမရ',
  'lamana'=> 'လမန',
  'malama'=> 'မလမ',
  'madana'=> 'မဒန',
  'thahpaya'=> 'သဖရ',
  'thahtana'=> 'သထန',
  'yamana'=> 'ရမန',
  'ahmana'=> 'အမန',
  'bathata'=> 'ဘသတ',
  'gamana'=> 'ဂမန',
  'kahpana'=> 'ကဖန',
  'katana'=> 'ကတန',
  'maahna'=> 'မအန',
  'maahta'=> 'မအတ',
  'mapana'=> 'မပန',
  'maouna'=> 'မဥန',
  'mapata'=> 'မပတ',
  'panata'=> 'ပဏတ',
  'yathata'=> 'ရသတ',
  'satana'=> 'စတန',
  'katala'=> 'ကတလ',
  'tapawa'=> 'တပ၀',
  'bahana'=> 'ဗဟန',
  'batahta'=> 'ဗတထ',
  'kakaka'=> 'ကကက',
  'dagaya'=> 'ဒဂရ',
  'dagama'=> 'ဒဂမ',
  'dagasa'=> 'ဒဂဆ',
  'dagata'=> 'ဒဂတ',
  'dagana'=> 'ဒဂန',
  'dalana'=> 'ဒလန',
  'dapana'=> 'ဒပန',
  'lathaya'=> 'လသယ',
  'ahsana'=> 'အစန',
  'khayana'=> 'ခရန',
  'kakhaka'=> 'ကခက',
  'katata'=> 'ကတတ',
  'lamata'=> 'လမတ',
  'mayaka'=> 'မရက',
  'magada'=> 'မဂဒ',
  'magata'=> 'မဂတ',
  'oukama'=> 'ဥကမ',
  'pabata'=> 'ပဘတ',
  'pazata'=> 'ပဇတ',
  'sakhana'=> 'စခန',
  'sakakha'=> 'ဆကခ',
  'yapatha'=> 'ရပသ',
  'oukata'=> 'ဥကတ',
  'tatahta'=> 'တတထ',
  'thakata'=> 'သကတ',
  'thalana'=> 'သလန',
  'thagaka'=> 'သဃက',
  'thakhana'=> 'သခန',
  'oukana'=> 'ဥကန',
  'ahkhana'=> 'အခန',
  'khayaha'=> 'ခရဟ',
  'hatana'=> 'ဟတန',
  'hapata'=> 'ဟပတ',
  'thanana'=> 'သနန',
  'sasana'=> 'ဆဆန',
  'thapana'=> 'သပန',
  'kalahpa'=> 'ကလဖ',
  'kalada'=> 'ကလဒ',
  'kamasa'=> 'ကမဆ',
  'kayana'=> 'ကရန',
  'kahana'=> 'ကဟန',
  'lakhana'=> 'လခန',
  'lakhata'=> 'လခတ',
  'lakata'=> 'လကတ',
  'lahtana'=> 'လထန',
  'mamasa'=> 'မမဆ',
  'matata'=> 'မတတ',
  'mahpana'=> 'မဖန',
  'manana'=> 'မနန',
  'masata'=> 'မဆတ',
  'nakhawa'=> 'နခဝ',
  'natana'=> 'နတန',
  'nakhata'=> 'နခတ',
  'nakhana'=> 'နခန',
  'namata'=> 'နမတ',
  'nahpana'=> 'နဖန',
  'nasana'=> 'နစန',
  'nakana'=> 'နကန',
  'nawana'=> 'န၀န',
  'naphana'=> 'နဖန',
  'nyayana'=> 'ညရန',
  'payana'=> 'ပယန',
  'pasana'=> 'ပဆန',
  'hpakhana'=> 'ဖခန',
  'pataya'=> 'ပတယ',
  'takhala'=> 'တခလ',
  'tayana'=> 'တယန',
  'yalana'=> 'ယလန',
  'yasana'=> 'ရစန',
  'yangana'=> 'ရငန',
  'nataya'=> 'နတယ',
  'khalana'=> 'ခလန',
  'mahaya'=> 'မဟရ',
  'papaka'=> 'ပပက',
  'tamanya'=> 'တမည',
  'mangana'=> 'မငန',
  'talana'=> 'တလန',
  'ahmata'=> 'အမတ',
  'bakala'=> 'ဘကလ',
  'danahpa'=> 'ဓနဖ',
  'dadaya'=> 'ဒဒရ',
  'hakaka'=> 'ဟကက',
  'hathata'=> 'ဟသတ',
  'ahgapa'=> 'အဂပ',
  'kakahta'=> 'ကကထ',
  'kapana'=> 'ကပန',
  'maahpa'=> 'မအပ',
  'mamaka'=> 'မမက',
  'ngapata'=> 'ငပတ',
  'ngathakha'=> 'ငသခ',
  'ngayaka'=> 'ငရက',
  'ngasana'=> 'ငဆန',
  'nyatana'=> 'ညတန',
  'pathana'=> 'ပသန',
  'pasala'=> 'ပစလ',
  'yathaya'=> 'ရသယ',
  'wakhama'=> 'ဝခမ',
  'zalana'=> 'ဇလန',
  'pathaya'=> 'ပသရ'
}

