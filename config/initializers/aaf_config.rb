_config_path = "#{Rails.root}/config"
RMMSeg::Config.dictionaries = [
  ["#{_config_path}/dicts/true/1.dict", true],  # with frequency info
  ["#{_config_path}/dicts/false/2.dict", false] # without
]
RMMSeg::Config.max_word_length = 6