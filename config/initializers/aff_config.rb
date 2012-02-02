_config_path_dicts = File.join(Rails.root, "config", "dicts")
_config_path_true = File.join(_config_path_dicts, 'true')
_config_path_false = File.join(_config_path_dicts, 'false')

RMMSeg::Config.dictionaries += [
  [File.join(_config_path_true, 'b.dict'), true],  # with frequency info
  [File.join(_config_path_false, 'a.dict'), false] # without
]

RMMSeg::Dictionary::instance.reload